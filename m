From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 06/10] ARM: Samsung: Modify
 s3c64xx_spi{0|1|2}_set_platdata function
Date: Wed, 9 May 2012 09:56:17 +0100
Message-ID: <20120509085617.GB28702@sirena.org.uk>
References: <1336514694-22393-1-git-send-email-thomas.abraham@linaro.org>
 <1336514694-22393-7-git-send-email-thomas.abraham@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: spi-devel-general@lists.sourceforge.net,
	devicetree-discuss@lists.ozlabs.org, kgene.kim@samsung.com,
	rob.herring@calxeda.com, grant.likely@secretlab.ca,
	jaswinder.singh@linaro.org, linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
To: Thomas Abraham <thomas.abraham@linaro.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1336514694-22393-7-git-send-email-thomas.abraham@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, May 09, 2012 at 03:34:50AM +0530, Thomas Abraham wrote:

> +	s3c64xx_spi0_set_platdata("s3c6410-spi", NULL, 0, 1);

Shouldn't we just set the name in the struct platform_device rather than
requiring the machine to pass it through by hand?
