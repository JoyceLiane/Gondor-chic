import { Component } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-login',
  standalone: true,
  imports: [FormsModule, CommonModule],
  templateUrl: './login.component.html',
  styleUrl: './login.component.css'
})
export class LoginComponent {
  pseudo = '';
  motDePasse = '';

  onSubmit(): void {
    if (this.pseudo.trim() && this.motDePasse.trim()) {
      console.log('Connexion avec :', this.pseudo);
    }
  }
}
