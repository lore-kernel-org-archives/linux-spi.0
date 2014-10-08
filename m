From: Thor Thayer <tthayer@opensource.altera.com>
Subject: Re: [PATCH 2/2] arm: dts: socfpga: Add SPI nodes & update copyright.
Date: Wed, 8 Oct 2014 13:05:35 -0500
Message-ID: <54357CEF.8000108@opensource.altera.com>
References: <1412711297-31857-1-git-send-email-tthayer@opensource.altera.com> <1412711297-31857-3-git-send-email-tthayer@opensource.altera.com> <20141007231200.GR4609@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: <jkosina@suse.cz>, <pawel.moll@arm.com>, <robh+dt@kernel.org>,
	<mark.rutland@arm.com>, <ijc+devicetree@hellion.org.uk>,
	<galak@codeaurora.org>, <dinguyen@opensource.altera.com>,
	<linux-spi@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <tthayer.linux@gmail.com>,
	<tthayer@altera.com>, <axel.lin@ingics.com>, <baruch@tkos.co.il>,
	<andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20141007231200.GR4609@sirena.org.uk>
Sender: linux-doc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


On 10/07/2014 06:12 PM, Mark Brown wrote:
> On Tue, Oct 07, 2014 at 02:48:17PM -0500,tthayer@opensource.altera.com  wrote:
>
>> Add 2 SPI nodes to SOCFPGA device tree. Update copyright.
>> Update spi-dw.txt with bus-num as an optional property.
> Again, this is just randomly mixing multiple changes.  Also why are we
> adding a bus-num property - bus numbers are an implementation detail of
> Linux and I can't see any reason to put them in the device tree.  If
> there were one the binding would need to explain what they were.
OK. I will leave these changes out of the patch.

Sorry about the noise. I saw the spi-summary referenced the bus-num 
spi<bus-num>.<chip-select> so I thought it could be added to the 
bindings document. The bus was defaulting to 32766 if the bus wasn't 
assigned from the device tree (spi32766.0).

Thanks,

Thor


