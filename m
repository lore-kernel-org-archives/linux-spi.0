From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 2/6] clk: st: clkgen-fsyn: Detect critical clocks
Date: Tue,  7 Jun 2016 12:19:26 +0100
Message-ID: <20160607111930.10375-3-lee.jones@linaro.org>
References: <20160607111930.10375-1-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: kernel@stlinux.com, mturquette@baylibre.com, sboyd@codeaurora.org,
 patrice.chotard@st.com, linux-spi@vger.kernel.org, broonie@kernel.org,
 Lee Jones <lee.jones@linaro.org>, linux-clk@vger.kernel.org,
 maxime.coquelin@st.com
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160607111930.10375-1-lee.jones@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

Utilise the new Critical Clock infrastructure to mark clocks which
much not be disabled as CRITICAL.

Clocks are marked as CRITICAL using clk flags.  This patch also
ensures flags are peculated through the framework in the correct
manner.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/clk/st/clkgen-fsyn.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/st/clkgen-fsyn.c b/drivers/clk/st/clkgen-fsyn.c
index dec4eaa..09afeb8 100644
--- a/drivers/clk/st/clkgen-fsyn.c
+++ b/drivers/clk/st/clkgen-fsyn.c
@@ -1027,7 +1027,7 @@ static const struct clk_ops st_quadfs_ops = {
 static struct clk * __init st_clk_register_quadfs_fsynth(
 		const char *name, const char *parent_name,
 		struct clkgen_quadfs_data *quadfs, void __iomem *reg, u32 chan,
-		spinlock_t *lock)
+		unsigned long flags, spinlock_t *lock)
 {
 	struct st_clk_quadfs_fsynth *fs;
 	struct clk *clk;
@@ -1045,7 +1045,7 @@ static struct clk * __init st_clk_register_quadfs_fsynth(
 
 	init.name = name;
 	init.ops = &st_quadfs_ops;
-	init.flags = CLK_GET_RATE_NOCACHE | CLK_IS_BASIC;
+	init.flags = flags | CLK_GET_RATE_NOCACHE | CLK_IS_BASIC;
 	init.parent_names = &parent_name;
 	init.num_parents = 1;
 
@@ -1115,6 +1115,7 @@ static void __init st_of_create_quadfs_fsynths(
 	for (fschan = 0; fschan < QUADFS_MAX_CHAN; fschan++) {
 		struct clk *clk;
 		const char *clk_name;
+		unsigned long flags = 0;
 
 		if (of_property_read_string_index(np, "clock-output-names",
 						  fschan, &clk_name)) {
@@ -1127,8 +1128,11 @@ static void __init st_of_create_quadfs_fsynths(
 		if (*clk_name == '\0')
 			continue;
 
+		of_clk_detect_critical(np, fschan, &flags);
+
 		clk = st_clk_register_quadfs_fsynth(clk_name, pll_name,
-				quadfs, reg, fschan, lock);
+						    quadfs, reg, fschan,
+						    flags, lock);
 
 		/*
 		 * If there was an error registering this clock output, clean
-- 
2.8.3
