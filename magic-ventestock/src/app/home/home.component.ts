import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { AuthService } from '../auth.service';

@Component({
  selector: 'app-home',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './home.component.html',
  styleUrl: './home.component.css'
})
export class HomeComponent {
  quantity = 1;

  constructor(public readonly authService: AuthService) {}

  decreaseQuantity(): void {
    if (this.quantity > 1) {
      this.quantity -= 1;
    }
  }

  increaseQuantity(maxQuantity?: number): void {
    if (maxQuantity == null || this.quantity < maxQuantity) {
      this.quantity += 1;
    }
  }
}