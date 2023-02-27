import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="like"
export default class extends Controller {
  add_like() {
    const configObj = {
      method: 'POST',
      headers: {
        "Content-Type": "application/json",
        Accept: "application/json"
      }
    };
    let user_id = window.location.pathname.split("/")[2];
    let post_id = window.location.pathname.split("/")[4];
    fetch(`../../../api/v1/members/${user_id}/posts/${post_id}/likes`, configObj);
  }

  remove_like() {
    const configObj = {
      method: 'DELETE',
      headers: {
        "Content-Type": "application/json",
        Accept: "application/json"
      }
    };
    let user_id = window.location.pathname.split("/")[2];
    let post_id = window.location.pathname.split("/")[4];
    fetch(`../../../api/v1/members/${user_id}/posts/${post_id}/likes/0`, configObj);
  }

  change() {
    const icon = document.getElementById("likes_counter");
    const counter = document.querySelector(".counter");
    if (icon.className == "bi-star") {
      icon.classList.add("bi-star-fill");
      icon.classList.remove("bi-star");
      this.add_like();
      counter.innerHTML = parseInt(counter.innerHTML) + 1;
    } else {
      icon.classList.add("bi-star");
      icon.classList.remove("bi-star-fill");
      this.remove_like();
      counter.innerHTML = parseInt(counter.innerHTML) - 1;
    }
  }
}
