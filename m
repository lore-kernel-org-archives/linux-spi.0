From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [RFC 1/4] clk: samsung: exynos5: Fix possible NULL pointer exception on platform_device_alloc() failure
Date: Mon, 18 Feb 2019 11:15:57 +0100
Message-ID: <1550484960-2392-2-git-send-email-krzk@kernel.org>
References: <1550484960-2392-1-git-send-email-krzk@kernel.org>
To: Russell King <linux@armlinux.org.uk>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1550484960-2392-1-git-send-email-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

During initialization of subdevices if platform_device_alloc() failed,
returned NULL pointer will be later dereferenced.  Add proper error
paths to exynos5_clk_register_subcmu().  The return value of this
function is still ignored because at this stage of init there is nothing
we can do.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/clk/samsung/clk-exynos5-subcmu.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5-subcmu.c b/drivers/clk/samsung/clk-exynos5-subcmu.c
index 93306283d764..d07ef26bd052 100644
--- a/drivers/clk/samsung/clk-exynos5-subcmu.c
+++ b/drivers/clk/samsung/clk-exynos5-subcmu.c
@@ -136,15 +136,21 @@ static int __init exynos5_clk_register_subcmu(struct device *parent,
 {
 	struct of_phandle_args genpdspec = { .np = pd_node };
 	struct platform_device *pdev;
+	int ret;
 
 	pdev = platform_device_alloc(info->pd_name, -1);
+	if (!pdev)
+		return -ENOMEM;
+
 	pdev->dev.parent = parent;
 	pdev->driver_override = "exynos5-subcmu";
 	platform_set_drvdata(pdev, (void *)info);
 	of_genpd_add_device(&genpdspec, &pdev->dev);
-	platform_device_add(pdev);
+	ret = platform_device_add(pdev);
+	if (ret)
+		platform_device_put(pdev);
 
-	return 0;
+	return ret;
 }
 
 static int __init exynos5_clk_probe(struct platform_device *pdev)
-- 
2.7.4
