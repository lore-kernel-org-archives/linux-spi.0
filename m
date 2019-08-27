From: Rob Herring <robh@kernel.org>
Subject: Re: [EXT] Re: [Patch v4 1/3] dt-bindings: spi: spi-fsl-qspi: Add
 ls2080a compatibility string to bindings
Date: Tue, 27 Aug 2019 10:50:05 -0500
Message-ID: <20190827155005.GA18581@bogus>
References: <1565691791-26167-1-git-send-email-Ashish.Kumar@nxp.com>
 <20190821110640.GC5128@sirena.co.uk>
 <VI1PR04MB401528B4F92DAD98385EF53395AA0@VI1PR04MB4015.eurprd04.prod.outlook.com>
 <VI1PR04MB4015474B3086AE99354FE65395A50@VI1PR04MB4015.eurprd04.prod.outlook.com>
 <20190822184927.GH23391@sirena.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
Content-Disposition: inline
In-Reply-To: <20190822184927.GH23391@sirena.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, Aug 22, 2019 at 07:49:27PM +0100, Mark Brown wrote:
> On Thu, Aug 22, 2019 at 06:39:18AM +0000, Ashish Kumar wrote:
> 
> > > > Please use subject lines matching the style for the subsystem.  This
> > > > makes it easier for people to identify relevant patches.
> > Hi Mark,
> 
> > After looking at some patch in Documentation/devicetree/bindings/spi/
> > I think I should update subject line to
> > dt-bindings: spi: Add ls2080-qspi compatible string for FSL QSPI driver
> > or 
> > doc: qspi: Add ls2080-qspi compatible to DT bindings for FSL QSPI driver
> 
> Drop the dt-bindings:.

If you do 'git log --oneline Documentation/devicetree/bindings/' you'll 
notice that SPI and ASoC are the oddballs now. I don't really care
except it does add to tribal knowledge needed regarding maintainers' 
requirements.

Rob
