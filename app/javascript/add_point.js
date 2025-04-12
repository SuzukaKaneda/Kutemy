document.addEventListener("DOMContentLoaded", function() {
  const targetPoints = document.getElementById("target-points").dataset.points;
  let userPoints = document.getElementById("user-points").dataset.points;
  const userId = document.getElementById("current-user").dataset.id;


  function showModal() {
    document.getElementById("goalAchievedModal").classList.remove("hidden");
  }

  document.querySelector(".close-button").addEventListener("click", function() {
  document.getElementById("goalAchievedModal").classList.add("hidden");
  window.location.href = `/users/${userId}/point`; // リダイレクト先のURLを指定
});

  // フォームの送信時にポイントを加算
  document.querySelector("form").addEventListener("submit", function(event) {
    event.preventDefault(); // デフォルトのフォーム送信を防ぐ

    const addPoints = parseInt(document.querySelector("input[name='add']").value, 10);
    userPoints += addPoints; // ポイントを加算

    // AJAXでサーバにポイントを加算するリクエストを送信
    fetch(this.action, {
      method: 'POST',
      body: new URLSearchParams(new FormData(this)),
      headers: {
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
      }
    }).then(response => {
      if (response.ok) {
        // サーバからのレスポンスを受けた後にポイントチェック
        if (userPoints >= targetPoints) {
         showModal(); // モーダルを表示
        } else {
          // リダイレクト処理
         window.location.href = `/users/${userId}/point`; // リダイレクト先のURLを指定
          alert('ポイントを加算しました。'); // noticeを表示
        }
      }
    });
  });
});
