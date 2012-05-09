From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 05/10] ARM: Samsung: Update the device names for spi
 clock lookup
Date: Wed, 9 May 2012 09:52:49 +0100
Message-ID: <20120509085249.GA28702@sirena.org.uk>
References: <1336514694-22393-1-git-send-email-thomas.abraham@linaro.org>
 <1336514694-22393-6-git-send-email-thomas.abraham@linaro.org>
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
In-Reply-To: <1336514694-22393-6-git-send-email-thomas.abraham@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, May 09, 2012 at 03:34:49AM +0530, Thomas Abraham wrote:
> With the addition of platform specific driver data in the spi-s3c64xx
> driver, the device name of spi controllers are changed. Accordingly,
> update the device name of spi clocks instances.

This should've been squashed into the patch that updated to use driver
data in order to avoid breaking bisection.
