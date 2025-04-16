document.addEventListener('turbo:load', () => {
  const rewardData = document.getElementById('reward-data');
  const targetPoints = parseInt(rewardData.dataset.requiredPoints, 10); // 数値に変換
  let userPoints = parseInt(rewardData.dataset.userPoints, 10); // 数値に変換
  let userId = rewardData.dataset.userId;
  let rewardId = rewardData.dataset.rewardId;

  function showModal() {
    document.getElementById("goalAchievedModal").classList.remove("hidden");
  }
  
  document.querySelector(".close-button").addEventListener("click", function() {
    document.getElementById("goalAchievedModal").classList.add("hidden");
    // リワードモデルのcompletedカラムを更新するリクエストを送る
    fetch(`/users/${userId}/rewards/${rewardId}/update_completed`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content') // CSRFトークンの追加
      },
      body: JSON.stringify({ completed: true }) // completedをtrueに設定
    })
    .then(response => {
      if (response.ok) {
        // リダイレクト先のURLを指定
        window.location.href = `/users/${userId}/rewards/new`;
      } else {
        console.error('Error updating reward');
    }
  })
  .catch(error => console.error('Error:', error));
  });
  
    // フォームの送信時にポイントを加算
  document.querySelector("form").addEventListener("submit", function(event) {
    event.preventDefault(); // デフォルトのフォーム送信を防ぐ
  
      // 送信ボタンを無効化
    const submitButton = this.querySelector('input[type="submit"]');
    submitButton.disabled = true;
  
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
            }
        }
    }).finally(() => {
        // 成功・失敗に関わらずボタンを再度有効化
        submitButton.disabled = false;
    });
  });
});
