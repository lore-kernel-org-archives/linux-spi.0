From: Joshua Clayton <stillcompiling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi: spidev_test: Fix input file check when transferring file
Date: Fri, 04 Nov 2016 03:50:45 -0700
Message-ID: <1716460.m4x0YRGYaN@diplodocus>
References: <1478255403-11149-1-git-send-email-vokac.m@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michal =?utf-8?B?Vm9rw6HEjQ==?= <vokac.m-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1478255403-11149-1-git-send-email-vokac.m-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi, Michal
On Friday, November 04, 2016 11:30:03 AM Michal Vok=C3=A1=C4=8D wrote:
> Check the input file fd instead of spidev fd.
> The spidev fd is supposed to be OK otherwise the transfer_file() func=
tion
> would not be called at all.
>=20
> Signed-off-by: Michal Vok=C3=A1=C4=8D <vokac.m-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  tools/spi/spidev_test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tools/spi/spidev_test.c b/tools/spi/spidev_test.c
> index f046b77..816f119 100644
> --- a/tools/spi/spidev_test.c
> +++ b/tools/spi/spidev_test.c
> @@ -315,7 +315,7 @@ static void transfer_file(int fd, char *filename)=

>  =09=09pabort("can't stat input file");
> =20
>  =09tx_fd =3D open(filename, O_RDONLY);
> -=09if (fd < 0)
> +=09if (tx_fd < 0)
>  =09=09pabort("can't open input file");
> =20
>  =09tx =3D malloc(sb.st_size);
>=20
Good catch. That is definitely a bug in the previous code.

Reviewed-by: Joshua Clayton <stillcompiling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
