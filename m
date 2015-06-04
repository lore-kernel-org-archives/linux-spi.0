From: Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH 08/11] MTD: m25p80: Add option to limit SPI transfer size.
Date: Thu, 4 Jun 2015 19:15:47 +0200
Message-ID: <20150604171547.GA1530@localhost.localdomain>
References: <cover.1433364398.git.hramrach@gmail.com>
 <8fc4b9f5291a509c4c35782a1337bf536f1019af.1433364398.git.hramrach@gmail.com>
 <CAMuHMdVT2M7pPHDDHmoNF_zVXhz1PUm5PiYxDKcAjSAcfSDiZg@mail.gmail.com>
 <CAOMqctS6KNrTATB6MYCZLBnZUQmX=e0qQvGf78YtLaF8pkibhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	MTD Maling List <linux-mtd@lists.infradead.org>,
	Alison Chaiken <alison_chaiken@mentor.com>,
	Bean Huo =?utf-8?B?6ZyN5paM5paMIChiZWFuaHVvKQ==?=
	<beanhuo@micron.com>, Marek Vasut <marex@denx.de>,
	"linux-samsung-soc@vger.kernel.org"
	<linux-samsung-soc@vger.kernel.org>,
	Russell King <linux@arm.linux.org.uk>,
	Vinod Koul <vinod.koul@intel.com>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
	Kukjin Kim <kgene@kernel.org>,
	Ben Hutchings <ben@decadent.org.uk>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Mark Brown <broonie@kernel.org>,
	Dan Williams <dan.j.williams@inte
To: Michal Suchanek <hramrach@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAOMqctS6KNrTATB6MYCZLBnZUQmX=e0qQvGf78YtLaF8pkibhQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, Jun 04, 2015 at 10:31:45AM +0200, Michal Suchanek wrote:
> You might want to try to run the bus at 60MHz or 80MHz and then the
> values would probably again be different.
> 
> The first two values are set in DT so the logical place for setting
> the third is also in DT.
> 
> Otherwise you would need some in-kernel table of these settings.

Or a formula.

Thanks,
Richard
