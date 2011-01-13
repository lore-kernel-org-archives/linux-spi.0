From: Yong Shen <yong.shen@linaro.org>
Subject: Re: [PATCH] ARM i.MX SPI driver changes for i.MX53 support
Date: Thu, 13 Jan 2011 11:12:07 +0800
Message-ID: <AANLkTimfcxbPq8G_LjO8tz8=nANFkd=5AJYjkTZQyrYG@mail.gmail.com>
References: <1294737713-24015-1-git-send-email-yong.shen@freescale.com>
	<1294737713-24015-2-git-send-email-yong.shen@freescale.com>
	<AANLkTikErJYCNRM1+-hx5Qrk_iW4Ad7fE1iFUODmqK6A@mail.gmail.com>
	<20110113030553.GC1392@angua.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general@lists.sourceforge.net, yong.shen@freescale.com,
	linux-arm-kernel@lists.infradead.org
To: Grant Likely <grant.likely@secretlab.ca>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20110113030553.GC1392@angua.secretlab.ca>
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

Thanks Grant. I am not asking somebody to merge it right now. I just
wonder who will take it, since maintainers change from time to time.

Yong

On Thu, Jan 13, 2011 at 11:05 AM, Grant Likely
<grant.likely@secretlab.ca> wrote:
> On Thu, Jan 13, 2011 at 11:01:44AM +0800, Yong Shen wrote:
>> Seems no comments from spi-devel list. This patch is also:
>> Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
>>
>> Who will take this patch into a tree?
>
> Patience Yong. =A0You only posted it two days ago. =A0It takes time for
> people to notice and respond some times.
>
> Normally, I wouldn't pick up a patch in the middle of the merge
> window, but this is pretty trivial, so I'll bend the rules this time.
>
> g.
>
>>
>> Yong
>>
>> On Tue, Jan 11, 2011 at 5:21 PM, =A0<yong.shen@freescale.com> wrote:
>> > From: Yong Shen <yong.shen@freescale.com>
>> >
>> > 1. Change the Kconfig to include i.MX53
>> > 2. add devtype entry for i.MX53
>> >
>> > Signed-off-by: Yong Shen <yong.shen@freescale.com>
>> > Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
>> > ---
>> > =A0drivers/spi/Kconfig =A0 | =A0 =A04 ++--
>> > =A0drivers/spi/spi_imx.c | =A0 =A06 ++++++
>> > =A02 files changed, 8 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
>> > index 78f9fd0..04965e2 100644
>> > --- a/drivers/spi/Kconfig
>> > +++ b/drivers/spi/Kconfig
>> > @@ -153,10 +153,10 @@ config SPI_IMX_VER_0_4
>> > =A0 =A0 =A0 =A0def_bool y if ARCH_MX31
>> >
>> > =A0config SPI_IMX_VER_0_7
>> > - =A0 =A0 =A0 def_bool y if ARCH_MX25 || ARCH_MX35 || ARCH_MX51
>> > + =A0 =A0 =A0 def_bool y if ARCH_MX25 || ARCH_MX35 || ARCH_MX51 || ARC=
H_MX53
>> >
>> > =A0config SPI_IMX_VER_2_3
>> > - =A0 =A0 =A0 def_bool y if ARCH_MX51
>> > + =A0 =A0 =A0 def_bool y if ARCH_MX51 || ARCH_MX53
>> >
>> > =A0config SPI_IMX
>> > =A0 =A0 =A0 =A0tristate "Freescale i.MX SPI controllers"
>> > diff --git a/drivers/spi/spi_imx.c b/drivers/spi/spi_imx.c
>> > index 55a38e2..9b8a733 100644
>> > --- a/drivers/spi/spi_imx.c
>> > +++ b/drivers/spi/spi_imx.c
>> > @@ -747,6 +747,12 @@ static struct platform_device_id spi_imx_devtype[=
] =3D {
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =3D "imx51-ecspi",
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.driver_data =3D SPI_IMX_VER_2_3,
>> > =A0 =A0 =A0 =A0}, {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "imx53-cspi",
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .driver_data =3D SPI_IMX_VER_0_7,
>> > + =A0 =A0 =A0 }, {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "imx53-ecspi",
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .driver_data =3D SPI_IMX_VER_2_3,
>> > + =A0 =A0 =A0 }, {
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* sentinel */
>> > =A0 =A0 =A0 =A0}
>> > =A0};
>> > --
>> > 1.7.1
>> >
>> >
>> >
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
