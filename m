From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH 1/3] SPI: spi_sh_msiof: cosmetic clean-up
Date: Tue, 25 Jan 2011 14:47:54 +0900
Message-ID: <20110125054754.GB11673@linux-sh.org>
References: <Pine.LNX.4.64.1101211654280.18867@axis700.grange> <20110121170247.GB7477@angua.secretlab.ca> <20110125050229.GA7183@verge.net.au> <AANLkTikJm9TEtzFRxYYVXAHgWV68JPamkg5ip6nk1C9h@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Simon Horman <horms@verge.net.au>,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
	spi-devel-general@lists.sourceforge.net, linux-sh@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AANLkTikJm9TEtzFRxYYVXAHgWV68JPamkg5ip6nk1C9h@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon, Jan 24, 2011 at 10:26:55PM -0700, Grant Likely wrote:
> On Mon, Jan 24, 2011 at 10:02 PM, Simon Horman <horms@verge.net.au> wrote:
> > Surely this is a bug in diff. Or perhaps put more politely,
> > diff isn't smart enough to realise a) this is C and b) xxx: isn't
> > a valid function name in C.
> 
> Oh, perhaps.  But regardless, it is long-standing behaviour and the
> single space convention is widely used.  Nobody seems offended enough
> by it to go and change diff.  To see, just do:
> 
>         git grep '^ [a-zA-Z0-9_]*:'
> 
> If it were particularly ugly, or actively dangerous, then I'd be
> against this pattern, but it is neither and it noticeably improves
> diff readability.
> 
It's largely a personal preference thing. I personally don't care for the
leading spaces, and remove them whenever I encounter them. I know that
Magnus and some others like to use them however, so generally don't care
one way or the other. I assume general apathy has a lot to do with diff
not being fixed (note that this topic does come up from time to time,
where the general conclusion is that someone should probably do something
about it, at some point in time).
