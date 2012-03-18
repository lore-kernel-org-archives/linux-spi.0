From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: bitbang: convert to using core message queue
Date: Mon, 19 Mar 2012 00:33:14 +0100
Message-ID: <CACRpkdZFobGAqO-8xe_JqA9stc=S6SHBCNEN4DSXy1AN5Ro8HQ@mail.gmail.com>
References: <Pine.LNX.4.64.1203141837170.30291@axis700.grange>
	<20120315092923.951203E04FD@localhost>
	<CACRpkdZNQZyx-HZjzyMctpUQJtNYMwq5KsdE6RTFwKcHuz_X+w@mail.gmail.com>
	<Pine.LNX.4.64.1203170036590.20979@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.64.1203170036590.20979-0199iw4Nj15frtckUFj5Ag@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Sat, Mar 17, 2012 at 12:39 AM, Guennadi Liakhovetski
<g.liakhovetski-Mmb7MZpHnFY@public.gmane.org> wrote:

> The SPI subsystem core now manages message queues internally. Remove the
> local message queue implementation from the spi-bitbang driver and
> migrate to the common one.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>

This is great stuff!
Acked-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

(Since I've never really used the bitbang driver I wouldn't trust me to
do any deeper review.)

Quick thought:

> +static int spi_bitbang_dummy_prepare(struct spi_master *master)
> +{
> + =A0 =A0 =A0 return 0;
(...)
> + =A0 =A0 =A0 master->prepare_transfer_hardware =3D spi_bitbang_dummy_pre=
pare;
> + =A0 =A0 =A0 master->unprepare_transfer_hardware =3D spi_bitbang_dummy_p=
repare;

Maybe we should think about making these two hooks optional if this
pattern turns up a lot. I'll try to fix some refactoring further down the
road if nobody beats me to it.

Yours,
Linus Walleij

---------------------------------------------------------------------------=
---
This SF email is sponsosred by:
Try Windows Azure free for 90 days Click Here =

http://p.sf.net/sfu/sfd2d-msazure
