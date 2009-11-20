From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC] MAINTAINERS: add SPI co-maintainer.
Date: Fri, 20 Nov 2009 11:01:40 -0700
Message-ID: <fa686aa40911201001m1ce0959dg21bcc2174653cd8a@mail.gmail.com>
References: <20091114001001.5343.99566.stgit@angua>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: akpm@linux-foundation.org, dbrownell@users.sourceforge.net,
	spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Stephen Rothwell <sfr@canb.auug.org.au>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754837AbZKTSCD@vger.kernel.org>
In-Reply-To: <20091114001001.5343.99566.stgit@angua>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Ping?  Any comments on this?

If I don't hear anything, then I think I'm going to go ahead and push
out a tree with all the SPI changes I've signed off on and ask sfr to
add it to his list, just so that I'm sure that they get some
linux-next exposure before Linus opens the merge window.  I won't
necessarily ask LInus to pull it, I just want the testing.

Cheers.
g.

On Fri, Nov 13, 2009 at 5:25 PM, Grant Likely <grant.likely@secretlab.c=
a> wrote:
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---
>
> Hi David, Andrew.
>
> David, I know that you haven't had enough time lately to keep on top
> of the pending SPI patches, so I was wondering if you would like some
> help? =A0If you are interested, I'm willing to act as co-maintainer o=
f
> for the SPI subsystem.
>
> Here's what I'm thinking. =A0Right now all SPI patches are going thro=
ugh
> the -mm tree and just adding to akpm's burden. =A0I'd be more than ha=
ppy
> to take over the task of actually collecting the acked patches into a
> git tree, getting them some exposure on linux-next, and asking Linus
> to pull it during the merge window. =A0If you ack them, then I'll mer=
ge
> them.
>
> I'm also be willing to take responsibility for all powerpc-specific
> SPI patches so that you don't need to look at them.
>
> How does this sound to you?
>
> Cheers,
> g.
>
> =A0MAINTAINERS | =A0 =A01 +
> =A01 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a1a2ace..2b697cb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4937,6 +4937,7 @@ F: =A0 =A0 =A0 =A0drivers/char/specialix*
>
> =A0SPI SUBSYSTEM
> =A0M: =A0 =A0 David Brownell <dbrownell@users.sourceforge.net>
> +M: =A0 =A0 Grant Likely <grant.likely@secretlab.ca>
> =A0L: =A0 =A0 spi-devel-general@lists.sourceforge.net
> =A0S: =A0 =A0 Maintained
> =A0F: =A0 =A0 Documentation/spi/
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
