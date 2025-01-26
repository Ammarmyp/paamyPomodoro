double calculateProgress(double current, double total) {
  double progress = current / total;
  return progress.clamp(0.00, 1.00);
}
