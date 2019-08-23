From: Vladimir Oltean <olteanv@gmail.com>
Subject: Re: [PATCH v2 2/5] spi: spi-fsl-dspi: Exit the ISR with IRQ_NONE when
 it's not ours
Date: Fri, 23 Aug 2019 15:06:52 +0300
Message-ID: <CA+h21hrj6VjceGJFz7XuS9DFjy=Fb5SHTYUuOWkagtsWf0Egbg@mail.gmail.com>
References: <20190822211514.19288-1-olteanv@gmail.com> <20190822211514.19288-3-olteanv@gmail.com>
 <20190823102816.GN23391@sirena.co.uk> <CA+h21hoUfbW8Gpyfa+a-vqVp_qARYoq1_eyFfZFh-5USNGNE2g@mail.gmail.com>
 <20190823105044.GO23391@sirena.co.uk> <20190823105949.GQ23391@sirena.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Cc: linux-spi@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, netdev <netdev@vger.kernel.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190823105949.GQ23391@sirena.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Mark,

On Fri, 23 Aug 2019 at 13:59, Mark Brown <broonie@kernel.org> wrote:
>
> On Fri, Aug 23, 2019 at 11:50:44AM +0100, Mark Brown wrote:
> > On Fri, Aug 23, 2019 at 01:30:27PM +0300, Vladimir Oltean wrote:
>
> > > Did you see this?
> > > https://lkml.org/lkml/2019/8/22/1542
>
> > I'm not online enough to readily follow that link right now, I
> > did apply another patch for a similar issue though.  If that's
> > a different version of the same change please don't do that,
> > sending multiple conflicting versions of the same thing creates
> > conflicts and makes everything harder to work with.
>
> Oh, I guess this was due to there being an existing refactoring
> in -next that meant the fix wouldn't apply directly.  I sorted
> that out now I think, but in general the same thing applies -
> it's better to put fixes before anything else in the series,
> it'll flag up when reviewing.

I try to require as little attention span as possible from you and I
apologize that I'm sending patches like a noob, but I'm not used to
this sort of interaction with a maintainer. It's taking me some time
to adjust expectations.
- You left change requests in the initial patchset I submitted, but
you partially applied the series anyway. You didn't give me a chance
to respin the whole series and put the shared IRQ fix on top, so it
applies on old trees as well. No problem, I sent two versions of the
patch.
- On my previous series you left this comment:

> Please don't include all the extra tags you've got in your subject
> lines.  In my inbox this series looks like:
>
>    790 N T 08/18 Vladimir Oltean ( 16K) =E2=94=9C=E2=94=80>[PATCH spi for=
-5.4 01/14] spi: spi-f
>
> so I can't tell what it's actually about just from looking at it.  Just
> [PATCH 01/14] would be enough, putting a target version in or versioning
> the patch series can be OK but you usually don't use a target version
> for -next and adding spi in there is redundant given that it's also in
> the changelog.

So I didn't put any target version in the patch titles this time,
although arguably it would have been clearer to you that there's a
patch for-5.4 and another version of it for-4.20 (which i *think* is
how I should submit a fix, I don't see any branch for inclusion in
stable trees per se).
No problem, I explained in the cover letters that one patchset is for
-next and the other is for inclusion in stable trees. Maintainers do
read cover letters, right?
Message from the -next cover letter:

> The series also contains a bug fix for the shared IRQ of the DSPI
> driver. I am going to respin a version of it as a separate patch for
> inclusion in stable trees, independent of this patchset.

Message from the fix's cover letter:

> This patch is taken out of the "Poll mode for NXP DSPI driver" series
> and respun against the "for-4.20" branch.
> $(git describe --tags 13aed2392741) shows:
> v4.20-rc1-18-g13aed2392741

Yes, I did send a cover letter for a single patch. I thought it's
harder to miss than a note hidden under patch 2/5 of one series, and
in the note section of the other's. I think you could have also made
an argument about me not doing it the other way around. In the end,
you can not read a note just as well as not read a cover letter, and
there's little I can do.

No problem, you missed the link between the two. I sent you a link to
the lkml archive. You said "I'm not online enough to readily follow
that link right now". Please teach me - I really don't know - how can
I make links between patchsets easier for you to follow, if you don't
read cover letters and you can't access lkml? I promise I'll use that
method next time.

> I do frequently catch up on my mail on flights or while otherwise
> travelling so this is even more pressing for me than just being about
> making things a bit easier to read.

Maybe you simply should do something else while traveling, just saying.

Regards,
-Vladimir
