From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 11/16] spi: pl022: Enable module alias autogeneration for
	AMBA drivers
Date: Wed, 5 Oct 2011 10:39:38 -0600
Message-ID: <CACxGe6tj3ZiLiHQjbRecymTLe6HhnF9=SBZj4_Fez8hZ1ekR9w@mail.gmail.com>
References: <1317830707-17517-1-git-send-email-dave.martin@linaro.org>
	<1317830707-17517-12-git-send-email-dave.martin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general@lists.sourceforge.net,
	=?UTF-8?Q?Pawe=C5=82_Moll?= <Pawel.Moll@arm.com>,
	linux-arm-kernel@lists.infradead.org, patches@linaro.org
To: Dave Martin <dave.martin@linaro.org>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1317830707-17517-12-git-send-email-dave.martin@linaro.org>
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

On Wed, Oct 5, 2011 at 10:05 AM, Dave Martin <dave.martin@linaro.org> wrote:
> Signed-off-by: Dave Martin <dave.martin@linaro.org>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> ---
> =A0drivers/spi/spi-pl022.c | =A0 =A02 ++
> =A01 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
> index f103e470..43abaf2 100644
> --- a/drivers/spi/spi-pl022.c
> +++ b/drivers/spi/spi-pl022.c
> @@ -2424,6 +2424,8 @@ static struct amba_id pl022_ids[] =3D {
> =A0 =A0 =A0 =A0{ 0, 0 },
> =A0};
>
> +MODULE_DEVICE_TABLE(amba, pl022_ids);
> +
> =A0static struct amba_driver pl022_driver =3D {
> =A0 =A0 =A0 =A0.drv =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =A0 =3D "ssp-pl022",
> --
> 1.7.4.1
>
>



-- =

Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
