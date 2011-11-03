From: Deepak Saxena <dsaxena@plexity.net>
Subject: Re: [PATCH 1/1] atmel/spi: fix missing probe during the switch to
	module_platform_driver
Date: Thu, 3 Nov 2011 10:55:15 -0400
Message-ID: <CAC4N5ENm9Q+MGb89V2S6QFE0KrB72BXxEBLm7EtAvwDdJEGSjA@mail.gmail.com>
References: <1320331706-4946-1-git-send-email-plagnioj@jcrosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: Grant Likely <grant.likely@secretlab.ca>,
	spi-devel-general@lists.sourceforge.net,
	Greg Kroah-Hartman <gregkh@suse.de>,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	linux-arm-kernel@lists.infradead.org
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1320331706-4946-1-git-send-email-plagnioj@jcrosoft.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

On Thu, Nov 3, 2011 at 10:48 AM, Jean-Christophe PLAGNIOL-VILLARD
<plagnioj@jcrosoft.com> wrote:
> in commit 940ab889
>
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Cc: Greg Kroah-Hartman <gregkh@suse.de>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
> =A0arch/arm/mach-at91/include/mach/at91_aic.h | =A0 =A02 +-
> =A0drivers/spi/spi-atmel.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =
=A01 +
> =A02 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-at91/include/mach/at91_aic.h b/arch/arm/mach-a=
t91/include/mach/at91_aic.h
> index 4b0a57e..f163bb6 100644
> --- a/arch/arm/mach-at91/include/mach/at91_aic.h
> +++ b/arch/arm/mach-at91/include/mach/at91_aic.h
> @@ -20,7 +20,7 @@
> =A0extern void __iomem *at91_aic_base;
>
> =A0#define at91_aic_read(field) \
> - =A0 =A0 =A0 __raw_read(at91_aic_base + field)
> + =A0 =A0 =A0 __raw_readl(at91_aic_base + field)
>
> =A0#define at91_aic_write(field, value) \
> =A0 =A0 =A0 =A0__raw_writel(value, at91_aic_base + field);
> diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
> index 79665e2..a691240 100644
> --- a/drivers/spi/spi-atmel.c
> +++ b/drivers/spi/spi-atmel.c
> @@ -1072,6 +1072,7 @@ static struct platform_driver atmel_spi_driver =3D {
> =A0 =A0 =A0 =A0},
> =A0 =A0 =A0 =A0.suspend =A0 =A0 =A0 =A0=3D atmel_spi_suspend,
> =A0 =A0 =A0 =A0.resume =A0 =A0 =A0 =A0 =3D atmel_spi_resume,
> + =A0 =A0 =A0 .probe =A0 =A0 =A0 =A0 =A0=3D atmel_spi_probe,
> =A0 =A0 =A0 =A0.remove =A0 =A0 =A0 =A0 =3D __exit_p(atmel_spi_remove),
> =A0};
> =A0module_platform_driver(atmel_spi_driver);

Jean,

This looks it should be two separate patches, one for the missing probe,
one for the raw_read -> raw_readl.

Thanks,
~Deepak
