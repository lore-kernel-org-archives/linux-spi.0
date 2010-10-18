From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 11/28] Blackfin SPI: convert struct
 names to something more logical
Date: Mon, 18 Oct 2010 00:20:25 -0600
Message-ID: <20101018062025.GD19399@angua.secretlab.ca>
References: <1287356381-31495-1-git-send-email-vapier@gentoo.org>
	<1287356381-31495-12-git-send-email-vapier@gentoo.org>
	<20101018060253.GA19399@angua.secretlab.ca>
	<AANLkTimJtoRWL0auw1xHthXbkBc6L2b1ph18WZA+_PdY@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
        David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
        uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
To: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Return-path: <uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <AANLkTimJtoRWL0auw1xHthXbkBc6L2b1ph18WZA+_PdY-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

On Mon, Oct 18, 2010 at 02:10:17AM -0400, Mike Frysinger wrote:
> On Mon, Oct 18, 2010 at 02:02, Grant Likely wrote:
> > On Sun, Oct 17, 2010 at 06:59:24PM -0400, Mike Frysinger wrote:
> >> -struct driver_data {
> >> +struct master_data {
> >
> > Or better yet, to protect against global collisions, bfin5xx_master perhaps?
> 
> i'd rather not.  there is too much "bfin5xx" stuff already which
> shouldnt exist.  what collision could there possibly be ?
> -mike

For driver code, anything at the file scope has a potential conflict
with the global scope.  If any header in include/linux were to define
a "master_data" or a "slave_data" structure, (those are pretty generic
names, it is well within the realm of possibilities) then it would
conflict.

A second reason for doing this is it helps reviewers/readers identify
the driver specific symbols.

For any driver code that I pick up, I pretty much require that
symbols in the file scope have a driver-specific prefix.

Also, now that I've looking at the existing code, it looks like
bfin_spi_ is the prefix that should actually be used, instead of
bfin5xx_

g.
