import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="confirm-dialog"
export default class extends Controller {
  // connect() {
  // }
  confirm(event) {
    event.preventDefault(); // デフォルトのリンク動作をキャンセル
    if (confirm("外部サイトに移動しますか？")) {
      window.open(event.target.href, '_blank'); // 新しいタブでリンクを開く
    }
  }
}
