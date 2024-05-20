import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="tabs"
export default class extends Controller {
  static targets = ["tab", "content"];
  // ページがロードされたときや、このコントローラが適用されたときに実行
  connect() {
    this.showActiveTab();
    this.showActiveContent();
  }
  // tabクリック時の処理
  changeTab(event) {
    this.tabTargets.forEach((tab) => {
      tab.classList.remove("tab-active");
    });
    event.currentTarget.classList.add("tab-active");
    this.showActiveContent();
  }

  showActiveContent() {
    const activeIndex = this.tabTargets.findIndex((tab) => tab.classList.contains("tab-active"));
    this.contentTargets.forEach((content, index) => {
      content.style.display = index === activeIndex ? "block" : "none";
    });
  }
}
