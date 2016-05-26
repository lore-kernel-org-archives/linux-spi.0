From: Christer Weinigel <christer@weinigel.se>
Subject: Re: [PATCH] devicetree - document using aliases to set spi bus
 number.
Date: Thu, 26 May 2016 12:58:22 +0200
Message-ID: <5746D6CE.5020605@weinigel.se>
References: <20160524172045.GN8206@sirena.org.uk>
 <57449784.4070108@weinigel.se> <20160524183256.GP8206@sirena.org.uk>
 <5744E51A.1040506@gmail.com> <20160525174932.GA10753@rob-hp-laptop>
 <5745E9B6.5090204@gmail.com> <20160525184442.GE8206@sirena.org.uk>
 <57464D0A.1030706@weinigel.se>
 <CAL_JsqJwQvPGtscheZjoJyhF1UPxDSqbS-QB9qm3M4HbpOicVA@mail.gmail.com>
 <574657BB.6070300@weinigel.se> <20160526100753.GB16172@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: Rob Herring <robh@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160526100753.GB16172@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 05/26/2016 12:07 PM, Mark Brown wrote:
> I think Rob's referring to the fact that there are no in tree DTs
> that use this feature - all the aliases for SPI controllers in
> mainline are string based.

One of the main drivers behind devicetree was that Linus got fed up
with the churn for all platform device changes in arch/arm.  I faintly
recall him writing that he would be rather unhappy if that just got
replaced with churn for devicetree dts files.

It makes sense to include dts files for reference boards in the
mainline kernel.  To include dts files for every vendors variant of a
design would add just as much churn and be rather pointless.  My guess
is that the dts file for most platforms are kept private.

For platforms based on a FPGA such as the Xilinx Zync it's even more
pointless to submit dts files to mainline.  When you have "hardware"
that can be reconfigured the device tree files can't be set in stone.
 If I use Xilinx tools [1] to add one more UART I have just added new
hardware this needs to be reflected in the devicetree for the devices
to be usable in Linux.  And something like aliases which provides a
stable device name can be very useful here.

  /Christer

[1] http://www.wiki.xilinx.com/Build+Device+Tree+Blob
