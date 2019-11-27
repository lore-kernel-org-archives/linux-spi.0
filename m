From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH] spi: cadence: Correct handling of native chipselect
Date: Wed, 27 Nov 2019 13:37:24 +0000
Message-ID: <20191127133724.GB10451@ediswmail.ad.cirrus.com>
References: <20191126164140.6240-1-ckeepax@opensource.cirrus.com>
 <CACRpkdYc=2vWte+gFp0m6RvWSu=+qT=WWUzag0N1FUBmbSCOOw@mail.gmail.com>
 <20191127115419.GA10451@ediswmail.ad.cirrus.com>
 <CACRpkdah5V7jDMUkDtdOb3RbR6mTsj5zs6g=Sb6KBZFRfme0rQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Gregory Clement <gregory.clement@bootlin.com>,
        Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdah5V7jDMUkDtdOb3RbR6mTsj5zs6g=Sb6KBZFRfme0rQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, Nov 27, 2019 at 12:59:34PM +0100, Linus Walleij wrote:
> On Wed, Nov 27, 2019 at 12:54 PM Charles Keepax
> <ckeepax@opensource.cirrus.com> wrote:
> > On Wed, Nov 27, 2019 at 11:42:47AM +0100, Linus Walleij wrote:
> > > On Tue, Nov 26, 2019 at 5:41 PM Charles Keepax
> > > <ckeepax@opensource.cirrus.com> wrote:
> > > But we are lucky: there aren't many of them.
> > > In addition to spi-cadence.c this seems to affect only spi-dw.c
> > > and I suppose that is what Gregory was using? Or
> > > something else?
> > >
> > I will go do some digging and see what I can find.

Yeah so looks to me like spi-dw is the only other part affected,
and it probably wants a similar revert done to fix it. It is a
little more complex as it has this additional cs_control
callback, but there don't appear to be any in tree users for that
(which I can find). So I am guessing any out of tree users
probably broke when the logic was first changed so the revert
probably helps them too, unless they have already changed there
callbacks in which case it will break them again.

Anyways I will send the revert and hopefully some people who use
the driver can test it for us.

Thanks,
Charles
