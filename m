From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [Uclinux-dist-devel] [PATCH]
 spi/bfin_sport_spi: new driver to emulate a SPI bus using Blackfin SPORT
 peripheral
Date: Mon, 10 Jan 2011 08:22:01 -0700
Message-ID: <20110110152201.GA392@angua.secretlab.ca>
References: <1287730415-6246-1-git-send-email-vapier@gentoo.org>
	<20101101055600.GC17587@angua.secretlab.ca>
	<AANLkTikpQHNRinCXOPFKfCqwCaNGa2VavFHG9juDw9cK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, Cliff Cai <cliff.cai-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>,
        David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
        Michael Hennerich <michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>,
        spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Return-path: <uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <AANLkTikpQHNRinCXOPFKfCqwCaNGa2VavFHG9juDw9cK-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://blackfin.uclinux.org/mailman/options/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://blackfin.uclinux.org/pipermail/uclinux-dist-devel>
List-Post: <mailto:uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
List-Help: <mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Errors-To: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, Jan 10, 2011 at 09:39:40AM -0500, Mike Frysinger wrote:
> On Mon, Nov 1, 2010 at 01:56, Grant Likely wrote:
> > On Fri, Oct 22, 2010 at 02:53:35AM -0400, Mike Frysinger wrote:
> >> + =A0 =A0 /* SPI framework hookup */
> >> + =A0 =A0 struct spi_master *master;
> >> +
> >> + =A0 =A0 /* Regs base of SPI controller */
> >> + =A0 =A0 volatile struct sport_register __iomem *regs;
> >
> > Drop the volatile. =A0Registers must never be dereferenced directly
> > anyway.
> >
> >> +static void bfin_sport_spi_enable(struct master_data *drv_data)
> >> +{
> >> + =A0 =A0 drv_data->regs->tcr1 |=3D TSPEN;
> >> + =A0 =A0 drv_data->regs->rcr1 |=3D TSPEN;
> >
> > Illegal direct dereference; use ioread/iowrite instead. =A0Ditto through
> > rest of file.
> =

> that's not correct.  ioread/iowrite are fine if the devices were
> generically mapped through say the asynchronous memory bus, but these
> registers arent.  they're mapped directly into the Blackfin hardware
> system bus and have different semantics than the async memory bus.

It is not okay to use direct register dereference in Linux for well
documented reasons (see volatile-considered-harmful.txt).  In
particular, accessors prevent either the compiler or the CPU from
reordering or optimizing out accesses to registers in a predictable
way.  volatile is strongly discouraged.  I may have the specific
accessor routine name wrong for the blackfin use case, but direct
dereference is definitely not okay.

> =

> >> + =A0 =A0 SSYNC();
> >
> > The SSYNC shouldn't be necessary with the correct accessors.
> =

> independently incorrect from the ioread/iowrite comment.  there's no
> way any register accessors function would ever impose a SSYNC on the
> Blackfin architecture.  this causes a *system* wide sync of *all*
> registers and as such, is used only when necessary.  if we did as you
> proposed and added them to every single read/write, it would kill
> performance.

Fair enough.

g.
