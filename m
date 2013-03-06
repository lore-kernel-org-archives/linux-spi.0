From: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Subject: Re: [PATCH] spi: add driver for BCM2835
Date: Wed, 6 Mar 2013 11:55:23 +0100
Message-ID: <CAOiHx==Nj8HtwuWi-4nmRorn44vYUfvOSi=UDQf8m5mo3AO4Cg@mail.gmail.com>
References: <1362538142-19246-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
 spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
 Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Chris Boot <bootc-1Slo4GeK4H1eoWH0uzbU5w@public.gmane.org>,
 linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1362538142-19246-1-git-send-email-swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rpi-kernel/>
List-Post: <mailto:linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "linux-rpi-kernel" <linux-rpi-kernel-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Just a small thing I spotted ...

On 6 March 2013 03:49, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote:
> (snip)
> +static int bcm2835_spi_probe(struct platform_device *pdev)
> +{
> (snip some more)
> +       /* initialise the hardware */
> +       clk_prepare_enable(bs->clk);

vs.

> +       bcm2835_wr(bs, BCM2835_SPI_CS,
> +                  BCM2835_SPI_CS_CLEAR_RX | BCM2835_SPI_CS_CLEAR_TX);
> +
> +       err = spi_register_master(master);
> +       if (err) {
> +               dev_err(&pdev->dev, "could not register SPI master: %d\n", err);
> +               goto out_clk_unprepare;
> +       }
> +
> +       return 0;
> +
> +out_clk_unprepare:
> +       clk_unprepare(bs->clk);

You are missing a disable here (the _remove() has it).

> +       free_irq(bs->irq, master);
> +out_master_put:
> +       spi_master_put(master);
> +       return err;
> +}
> +


Jonas
