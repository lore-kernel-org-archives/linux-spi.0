From: Hans Eklund <hans-9ai+6vhHfRGzQB+pC5nmwQ@public.gmane.org>
Subject: Re: [spi-devel-general] spi_mmc bus
 concurrency fix
Date: Tue, 25 Mar 2008 11:25:08 +0100
Message-ID: <47E8D304.6030001@rubico.se>
References: <47C42D50.7020204@rubico.se>
	<200802272155.29706.david-b@pacbell.net> <47C66D8A.3010904@cox.net>
	<200803121501.19131.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>,
        uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, bryan.wu-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
In-Reply-To: <200803121501.19131.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Unsubscribe: <http://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://blackfin.uclinux.org/pipermail/uclinux-dist-devel>
List-Post: <mailto:uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
List-Help: <mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <http://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Errors-To: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi again.

Lets move on.

I have not solved the roots to the problem. I=B4ve not been given time to =

fiddle with the framework internals. Im not sure im the man to do that =

in the end. But, I have managed to get MMC/SD cards running concurrently =

with m25p80 spi flash driver. No fix to either the master
driver or the framework. Both reading and writing and card init works. =

No multiple block writing yet though. All done vs uClinux 2008R1-RC8 =

(kernel 2.6.22) and my old spi_mmc driver which implemented a separate =

block layer. Written and tested mostly within the Blackfin uClinux =

community.

About the fix: In short i predefine a sequence of transfers in a single =

message matching the MMC/SD protocol, simply assuming it will work, =

checking the tokens and if tokens looked fine return with a smile. It =

seem to work. It is the only way to get atomicity on the bus for now. It =

is surley best to patch up the drivers/mmc/host/mmc_spi.c code and use =

that driver from now on, putting my old spi_mmc driver on the shelf.

Bryan, Mike and other Blackfin-uClinux developers:

What is the status on the drivers/mmc/host/mmc_spi.c when connected to =

the Blackfin spi master? Mike pointed out that my old spi_mmc should be =

obsoleted(with all rights), with that statement I got the feeling the =

"new" mainline driver was tested to some extent, correct? I would need a =

test/develop environment to move on with this. I=B4ll try to backport the =

mmc_spi found in 2.6.24 to fit 2008R1-RC8 as a start, or do you have any =

other suggestions?

I hope i get the attention of Jan Nikitenko and Hans-Peter Nilsson on =

this subject also as they seem to have been a part of the mmc_spi driver =

developing.

/regards
Hans Eklund,
Rubico AB,
Sweden.

David Brownell skrev:
> On Thursday 28 February 2008, Phil Wilshire wrote:
>> I agree, I did have some concerns about the callback issue.
>> It also looks like we have enough people + momentum on this problem to
>> get a fix in good time. So I'll wait to see what happens.
> =

> Actually, I'm not sure I'd agree on that.  Folk want a fix,
> but nobody (including me!) has sent something that's quite
> mergeable yet.
> =

> I think part of the solution may be what someone (Brian?)
> observed:  that growing the mid-layer to handle some of the
> queue management functions should help, no matter what
> eventual solution is adopted.
> =

> That might be as little as providing a default "add to queue"
> and "take from queue" mechanism and starting to phase it into
> use in the various master controller drivers.  When they use
> that scheme, it should be easy to splice in alternative queue
> management policies (notably:  "only spi_mmc can access the
> bus for now") without changing the controller drivers.
> =

> So it'd be really nice if someone could come up with a patch
> like that to help get some forward motion ... unless there's
> a better suggestion for how to move forward?
> =

> - Dave
> =

> =
