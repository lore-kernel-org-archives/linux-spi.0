From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 4/6] SPI: S3C64XX: Check before
	mem-region release
Date: Mon, 18 Jan 2010 11:12:09 -0700
Message-ID: <fa686aa41001181012s57c0e863s6b9b6b2724514a9f@mail.gmail.com>
References: <1263808215-16544-1-git-send-email-jassisinghbrar@gmail.com>
	<1263808215-16544-2-git-send-email-jassisinghbrar@gmail.com>
	<1263808215-16544-3-git-send-email-jassisinghbrar@gmail.com>
	<1263808215-16544-4-git-send-email-jassisinghbrar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	ben-SMNkleLxa3Z6Wcw2j4pizdi2O/JbrIOy@public.gmane.org
To: jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1263808215-16544-4-git-send-email-jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, Jan 18, 2010 at 2:50 AM,  <jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> From: Jassi Brar <jassi.brar-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>
> Add precautionary check before releasing memory region.
>
> Signed-off-by: Jassi Brar <jassi.brar-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> ---
> =A0drivers/spi/spi_s3c64xx.c | =A0 =A03 ++-
> =A01 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/spi/spi_s3c64xx.c b/drivers/spi/spi_s3c64xx.c
> index 3acf381..0e883f9 100644
> --- a/drivers/spi/spi_s3c64xx.c
> +++ b/drivers/spi/spi_s3c64xx.c
> @@ -1097,7 +1097,8 @@ static int s3c64xx_spi_remove(struct platform_devic=
e *pdev)
> =A0 =A0 =A0 =A0iounmap((void *) sdd->regs);
>
> =A0 =A0 =A0 =A0mem_res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> - =A0 =A0 =A0 release_mem_region(mem_res->start, resource_size(mem_res));
> + =A0 =A0 =A0 if (mem_res !=3D NULL)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 release_mem_region(mem_res->start, resource=
_size(mem_res));


request_mem_region() in in an unconditional path in the .probe() hook.
 Are you seeing failure on the remove path?

g.

---------------------------------------------------------------------------=
---
Throughout its 18-year history, RSA Conference consistently attracts the
world's best and brightest in the field, creating opportunities for Confere=
nce
attendees to learn about information security's most important issues throu=
gh
interactions with peers, luminaries and emerging and established companies.
http://p.sf.net/sfu/rsaconf-dev2dev
