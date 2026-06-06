import { Injectable } from '@angular/core';
import { Router } from '@angular/router';
import rawData from '../../../data.json';

type Client = {
  prenom: string;
  nom: string;
  pseudo: string;
  mot_de_pass: string;
};

type Produit = {
  libelle: string;
  prix_gar: number;
  quantite_stock: number;
  est_du_jour: boolean;
  image: string;
};

@Injectable({
  providedIn: 'root'
})
export class AuthService {
  currentUser?: Client;
  clients: Client[] = rawData.data.clients;
  produits: Produit[] = rawData.data.produits;

  constructor(private readonly router: Router) {}

  login(pseudo: string, motDePasse: string): boolean {
    const normalizedPseudo = pseudo.trim();
    const normalizedPwd = motDePasse.trim();

    if (!normalizedPseudo || !normalizedPwd) {
      return false;
    }

    const matchedClient = this.clients.find(
      client =>
        client.pseudo === normalizedPseudo && client.mot_de_pass === normalizedPwd
    );

    if (!matchedClient) {
      return false;
    }

    this.currentUser = matchedClient;
    return true;
  }

  get displayName(): string {
    if (!this.currentUser) {
      return 'Invité';
    }
    return `${this.currentUser.prenom} ${this.currentUser.nom}`;
  }

  get produitDuJour(): Produit | undefined {
    return this.produits.find(produit => produit.est_du_jour);
  }

  redirectToHome(): void {
    this.router.navigate(['/home']);
  }
}
