From: Rob Herring <robh@kernel.org>
Subject: Re: [EXT] Re: [Patch v4 1/3] dt-bindings: spi: spi-fsl-qspi: Add
 ls2080a compatibility string to bindings
Date: Wed, 28 Aug 2019 15:01:15 -0500
Message-ID: <CAL_JsqKnY1ucejpaSUYu_dGZ=uHMybsW4ryJAtEgimUXB+ozbg@mail.gmail.com>
References: <1565691791-26167-1-git-send-email-Ashish.Kumar@nxp.com>
 <20190821110640.GC5128@sirena.co.uk> <VI1PR04MB401528B4F92DAD98385EF53395AA0@VI1PR04MB4015.eurprd04.prod.outlook.com>
 <VI1PR04MB4015474B3086AE99354FE65395A50@VI1PR04MB4015.eurprd04.prod.outlook.com>
 <20190822184927.GH23391@sirena.co.uk> <20190827155005.GA18581@bogus> <20190827195606.GA28879@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Ashish Kumar <ashish.kumar@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        Kuldeep Singh <kuldeep.singh@nxp.com>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190827195606.GA28879@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, Aug 27, 2019 at 2:56 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, Aug 27, 2019 at 10:50:05AM -0500, Rob Herring wrote:
> > On Thu, Aug 22, 2019 at 07:49:27PM +0100, Mark Brown wrote:
>
> > > Drop the dt-bindings:.
>
> > If you do 'git log --oneline Documentation/devicetree/bindings/' you'll
> > notice that SPI and ASoC are the oddballs now. I don't really care
> > except it does add to tribal knowledge needed regarding maintainers'
> > requirements.
>
> Well, you have been pushing people to change over to using
> dt-bindings: so I guess you do care :(

Well, yes. In the absence of any sort of pattern, I have pushed for
some consistency. And to get rid of subjects like this:

Documentation/devicetree/bindings: Add the DT binding documentation for foo-bar

If subsystems are consistent with their own standard as you are, then
as a maintainer I don't really care. My point was in regard to what
submitters need to know and follow.

> It really does cause me
> to miss stuff, especially where people don't even include the
> subsystem name in the header.  I get quite a lot of CCs for
> things where I once reviewed a patch for a subsystem that made
> use of some subsystem I do maintain or where one patch in a
> series (perhaps even an already applied one) was relevant at some
> point so I'm doing quite a bit of triage that's purely based on
> the subject lines.

I can't imagine filtering on subjects will ever be that reliable
unless we add subject prefixes to MAINTAINERS and have checkpatch
check commits against those. Filtering on the diffstat is the only
thing that's kept things to a sane list for me (MAINTAINERS for DT
used to tag of_* functions which just meant getting copied on *every*
driver). This is done on the patchwork server side for me, but I
imagine one could do it on the client side too.

Rob
