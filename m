From: Stephen Boyd <swboyd@chromium.org>
Subject: [PATCH 0/3] Misc qcom geni spi driver fixes
Date: Tue,  4 Feb 2020 11:12:03 -0800
Message-ID: <20200204191206.97036-1-swboyd@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-spi@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Here's a small collection of qcom geni spi driver fixes that
simplify the code and aid debugging.

Stephen Boyd (3):
  spi: spi-geni-qcom: Let firmware specify irq trigger flags
  spi: spi-geni-qcom: Grow a dev pointer to simplify code
  spi: spi-geni-qcom: Drop of.h include

 drivers/spi/spi-geni-qcom.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

-- 
Sent by a computer, using git, on the internet
