From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH v3 10/12] backlight: add support for tps6116x controller
Date: Thu, 21 Oct 2010 14:19:22 -0700
Message-ID: <1287695962.15567.98.camel@Joe-Laptop>
References: <1287694873-12904-1-git-send-email-cyril@ti.com>
	 <1287694873-12904-11-git-send-email-cyril@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: davinci-linux-open-source@linux.davincidsp.com,
	spi-devel-general@lists.sourceforge.net,
	broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk,
	dbrownell@users.sourceforge.net, grant.likely@secretlab.ca,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	rpurdie@rpsys.net
To: Cyril Chemparathy <cyril@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1287694873-12904-11-git-send-email-cyril@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, 2010-10-21 at 17:01 -0400, Cyril Chemparathy wrote:
> diff --git a/drivers/video/backlight/tps6116x.c b/drivers/video/backlight/tps6116x.c

just some trivia:

> @@ -0,0 +1,340 @@
[]
> +struct tps6116x {
> +	struct ti_ssp_device		*handle;
> +	struct device			*dev;
> +	int				gpio, gpio_initialized;
> +	struct mutex			lock;
> +	int				intensity;
> +	int				power;
> +	struct backlight_properties	props;
> +	struct backlight_device		*bl;
> +	int				suspended:1;
> +	struct regulator		*regulator;
> +};

Perhaps several of these should be bool.
gpio_initialized, power, suspended

[]

> +static int __devinit tps6116x_probe(struct platform_device *pdev)
> +{
> +	struct tps6116x *hw;
> +	struct device *dev = &pdev->dev;
> +	struct backlight_properties props;
> +	int error;
> +
> +	hw = kzalloc(sizeof(struct tps6116x), GFP_KERNEL);
> +	if (!hw) {
> +		error = -ENOMEM;
> +		dev_err(dev, "cannot allocate driver data\n");
> +		goto fail0;
> +	}
> +	platform_set_drvdata(pdev, hw);
> +
> +	memset(hw, 0, sizeof(struct tps6116x));

Unnecessary memset.
