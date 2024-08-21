import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="loading"
export default class extends Controller {
  showLoading() {
    // 検索結果を隠す
    const results = document.querySelector('[data-loading-target="results"]');
    if (results) {
      results.classList.add('hidden'); // 結果を隠す
    }
    // ローディングを表示
    const loading = document.querySelector('[data-loading-target="loading"]');
    if (loading) {
      loading.classList.remove('hidden'); // ローディングを表示
    }
  }

  hideLoading() {
    // ローディングを非表示に
    const loading = document.querySelector('[data-loading-target="loading"]');
    if (loading) {
      loading.classList.add('hidden');
    }
    // 結果を表示
    const results = document.querySelector('[data-loading-target="results"]');
    if (results) {
      results.classList.remove('hidden'); // 結果を表示
    }
  }
}
