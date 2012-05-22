From: David Daney <ddaney.cavm@gmail.com>
Subject: Re: [PATCH 1/3] of: Add prefix parameter to of_modalias_node().
Date: Tue, 22 May 2012 15:49:43 -0700
Message-ID: <4FBC1807.4050402@gmail.com>
References: <1336773923-17866-1-git-send-email-ddaney.cavm@gmail.com> <1336773923-17866-2-git-send-email-ddaney.cavm@gmail.com> <20120520055436.13AF03E03B8@localhost> <20120520060802.03CE73E03B8@localhost> <4FBBECC2.10503@gmail.com> <CACxGe6tYQVfPRtXxmYF2OPYcEFu+x4-_uzFta9f3mwu=xUrt=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "devicetree-discuss@lists.ozlabs.org"
	<devicetree-discuss@lists.ozlabs.org>,
	Rob Herring <rob.herring@calxeda.com>,
	"spi-devel-general@lists.sourceforge.net"
	<spi-devel-general@lists.sourceforge.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	Liam Girdwood <lrg@ti.com>,
	Tabi Timur-B04825 <B04825@freescale.com>,
	Mark Brown <broonie@opensource.wolfsonmicro.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>,
	"alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
To: Grant Likely <grant.likely@secretlab.ca>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <CACxGe6tYQVfPRtXxmYF2OPYcEFu+x4-_uzFta9f3mwu=xUrt=g@mail.gmail.com>
Sender: linux-doc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 05/22/2012 01:09 PM, Grant Likely wrote:
> On Tue, May 22, 2012 at 1:45 PM, David Daney<ddaney.cavm@gmail.com>  wrote:
>> On 05/19/2012 11:08 PM, Grant Likely wrote:
>>>
>>> On Sat, 19 May 2012 23:54:36 -0600, Grant
>>> Likely<grant.likely@secretlab.ca>    wrote:
>>>>
>>>> On Fri, 11 May 2012 15:05:21 -0700, David Daney<ddaney.cavm@gmail.com>
>>>>   wrote:
>>>>>
>>>>> From: David Daney<david.daney@cavium.com>
>>>>>
>>>>> When generating MODALIASes, it is convenient to add things like "spi:"
>>>>> or "i2c:" to the front of the strings.  This allows the standard
>>>>> modprobe to find the right driver when automatically populating bus
>>>>> children from the device tree structure.
>>>>>
>>>>> Add a prefix parameter, and adjust callers.  For
>>>>> of_register_spi_devices() use the "spi:" prefix.
>>>>>
>>>>> Signed-off-by: David Daney<david.daney@cavium.com>
>>>>
>>>>
>>>> Applied, thanks.  Some notes below...
>>>
>>>
>>> Wait... why is this necessary?
>>
>>
>> Because in of_register_spi_devices() in of_spi.c, you do:
>>
>>         request_module(spi->modalias);
>>
>> The string passed to request_module() must have the "spi:" prefix.
>
> How about modifying the call to request_module() to include the prefix
> also?  I think that would be a simpler change overall.  Would that
> work?

It seems to.  I just sent such a patch in a new thread.

David Daney
