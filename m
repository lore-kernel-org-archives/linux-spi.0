From: takasi-y@ops.dti.ne.jp
Subject: [PATCH 01/11] pinctrl: sh-pfc: r8a7791: fix msiof groups to follow GROUP
Date: Mon,  2 Dec 2013 03:19:12 +0900
Message-ID: <1385921962-19843-1-git-send-email-takasi-y@ops.dti.ne.jp>
References: <20131202031557.162e78d407d82effdee627ac@ops.dti.ne.jp>
Cc: Simon Horman <horms@verge.net.au>,
	Magnus Damm <magnus.damm@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
To: linux-sh@vger.kernel.org
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20131202031557.162e78d407d82effdee627ac@ops.dti.ne.jp>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Takashi Yoshii <takasi-y@ops.dti.ne.jp>

SH_PFC_PIN_GROUP(), pins[], mux[], defines
 clk, sync, ss1, ss2, rx, tx
But, msiof?_groups[] defines
 clk, ctrl, data

Fix msiof[012]_groups members to be consistent to PIN_GROUP.

Signed-off-by: Takashi Yoshii <takasi-y@ops.dti.ne.jp>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7791.c |   21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7791.c b/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
index bf76a65..e0be506 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
@@ -2840,20 +2840,29 @@ static const char * const mmc_groups[] = {
 
 static const char * const msiof0_groups[] = {
 	"msiof0_clk",
-	"msiof0_ctrl",
-	"msiof0_data",
+	"msiof0_sync",
+	"msiof0_ss1",
+	"msiof0_ss2",
+	"msiof0_rx",
+	"msiof0_tx",
 };
 
 static const char * const msiof1_groups[] = {
 	"msiof1_clk",
-	"msiof1_ctrl",
-	"msiof1_data",
+	"msiof1_sync",
+	"msiof1_ss1",
+	"msiof1_ss2",
+	"msiof1_rx",
+	"msiof1_tx",
 };
 
 static const char * const msiof2_groups[] = {
 	"msiof2_clk",
-	"msiof2_ctrl",
-	"msiof2_data",
+	"msiof2_sync",
+	"msiof2_ss1",
+	"msiof2_ss2",
+	"msiof2_rx",
+	"msiof2_tx",
 };
 
 static const char * const scif0_groups[] = {
-- 
1.7.9.5

