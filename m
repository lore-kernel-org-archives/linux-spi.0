From: David Wood <david-FXZ7EUqcgyfQXOPxS62xeg@public.gmane.org>
Subject: Re: [PATCH] spi: Fix warning about redefinition
Date: Wed, 6 Aug 2014 20:53:41 +0200
Message-ID: <CAO+Sx3nGKN1jh0VB9NjcFCqV7ZmWWjJge0nohdUGta9BF60EWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Nick Krause <xerofoiffy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"open list:SPI SUBSYSTEM" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Richard Weinberger <richard.weinberger-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, 6 Aug 2014 11:33:28 -0700, Guenter Roeck wrote:
> On Wed, Aug 06, 2014 at 07:19:54PM +0200, Richard Weinberger wrote:
> > On Wed, Aug 6, 2014 at 6:55 PM, Nick Krause <xerofoiffy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > > Fix the following warnings about redefining READ and write
> > >
> > > drivers/spi/spi-omap-100k.c:73:0: warning: "WRITE" redefined [enabled by default]
> > > include/linux/fs.h:193:0: note: this is the location of the previous definition
> > > drivers/spi/spi-omap-100k.c:74:0: warning: "READ" redefined [enabled by default]
> > > include/linux/fs.h:192:0: note: this is the location of the previous definition
> > >
> > > Signed-off-by: Nick Krause <xerofoiffy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > > ---
> > >  drivers/spi/spi-omap-100k.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >
> > > diff --git a/drivers/spi/spi-omap-100k.c b/drivers/spi/spi-omap-100k.c
> > > index 5e91858..eb8ae4e 100644
> > > --- a/drivers/spi/spi-omap-100k.c
> > > +++ b/drivers/spi/spi-omap-100k.c
> > > @@ -70,6 +70,12 @@
> > >  #define SPI_STATUS_WE                   (1UL << 1)
> > >  #define SPI_STATUS_RD                   (1UL << 0)
> > >
> > > +#ifdef WRITE
> > > +#undef WRITE
> > > +#endif
> > > +#ifdef READ
> > > +#undef READ
> > > +#endif
> > >  #define WRITE 0
> > >  #define READ  1
> >
> > Are these symbols even in use?
> >
>
> It is always fun watching those patches flow by :-)
> With the following patch:
> diff --git a/drivers/spi/spi-omap-100k.c b/drivers/spi/spi-omap-100k.c
> index 5e91858..f72ddfc 100644
> --- a/drivers/spi/spi-omap-100k.c
> +++ b/drivers/spi/spi-omap-100k.c
> @@ -70,8 +70,8 @@
>  #define SPI_STATUS_WE                   (1UL << 1)
>  #define SPI_STATUS_RD                   (1UL << 0)
> -#define WRITE 0
> -#define READ  1
> +#undef WRITE
> +#undef READ
> [ just to make sure that no existing defines are used instead of the new ones ]
> When compiling the resulting code with W=1, I get:
> drivers/spi/spi-omap-100k.c: In function 'spi100k_read_data':
> drivers/spi/spi-omap-100k.c:148:6: warning: variable 'dataH' set but not used
> [-Wunused-but-set-variable]
> So, one might conclude that the defines are not used.
> Guenter

There's also no need to have the undefines, as the READ is defined as
0 in linux/fs.h, and WRITE as 1 (WRITE = RW_MASK = REQ_WRITE = 1ULL <<
__REQ_WRITE, with __REQ_WRITE being defined in enum rq_flag_bits {
__REQ_WRITE = 0; };), so even if it did try to use those definitions,
it wouldn't then matter.
Unfortunately, neither the linux source code, nor the linwizard source
(from which this file was copied) show how the defines got there, they
appear to have been in the code ever since Nokia originally wrote the
file in 2005. So the following should be sufficient:

diff --git a/drivers/spi/spi-omap-100k.c b/drivers/spi/spi-omap-100k.c
index 5e91858..1dbb706 100644
--- a/drivers/spi/spi-omap-100k.c
+++ b/drivers/spi/spi-omap-100k.c
@@ -70,9 +70,6 @@
 #define SPI_STATUS_WE                   (1UL << 1)
 #define SPI_STATUS_RD                   (1UL << 0)

-#define WRITE 0
-#define READ  1
-

 /* use PIO for small transfers, avoiding DMA setup/teardown overhead and
  * cache operations; better heuristics consider wordsize and bitrate.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
