From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH RESEND v4] spi/pl022: add devicetree support
Date: Mon, 20 Aug 2012 10:53:35 -0500
Message-ID: <50325D7F.5050003@gmail.com>
References: <1345462769-17386-1-git-send-email-aletes.xgr@gmail.com> <50324835.6030806@gmail.com> <503258CE.9030106@antcom.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Alexandre Pereira da Silva <aletes.xgr@gmail.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Landley <rob@landley.net>,
	devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	spi-devel-general@lists.sourceforge.net,
	"Mark Brown (broonie@opensource.wolfsonmicro.com)"
	<broonie@opensource.wolfsonmicro.com>,
	Linus Walleij <linus.walleij@linaro.org>
To: Roland Stigge <stigge@antcom.de>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <503258CE.9030106@antcom.de>
Sender: linux-doc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 08/20/2012 10:33 AM, Roland Stigge wrote:
> On 08/20/2012 04:22 PM, Rob Herring wrote:
>>>  .../devicetree/bindings/spi/spi_pl022.txt          |   15 +++
>>>  drivers/spi/spi-pl022.c                            |  114 ++++++++++++++++----
>>>  2 files changed, 110 insertions(+), 19 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/spi/spi_pl022.txt b/Documentation/devicetree/bindings/spi/spi_pl022.txt
>>> index 306ec3f..b089ec7 100644
>>> --- a/Documentation/devicetree/bindings/spi/spi_pl022.txt
>>> +++ b/Documentation/devicetree/bindings/spi/spi_pl022.txt
>>> @@ -6,7 +6,22 @@ Required properties:
>>>  - interrupts : Should contain SPI controller interrupt
>>>  
>>>  Optional properties:
>>> +- pl022,num-chipselects : total number of chipselects
>>
>> We have this for other spi controllers too. Define a generic property.
> 
> Currently, we have:
> 
> num-cs
> ti,spi-num-cs
> fsl,spi-num-chipselects
> fsl,espi-num-chipselects
> (pl022,num-chipselects)
> 
> Would "num-cs" be the right one to use?

Well, it is either that or invent something new, so I think num-cs is fine.

Rob
