From: Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH v2] spi: orion.c: Add direct access mode
Date: Tue, 5 Apr 2016 09:11:27 +0200
Message-ID: <5703651F.4040901@denx.de>
References: <1458663893-13766-1-git-send-email-sr@denx.de>
 <3108005.nUMWsj4kjp@wuerfel> <20160329212842.GN2350@sirena.org.uk>
 <13533301.gfdhE3AuMf@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>,
	Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <13533301.gfdhE3AuMf@wuerfel>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 30.03.2016 00:04, Arnd Bergmann wrote:
> On Tuesday 29 March 2016 14:28:42 Mark Brown wrote:
>> On Tue, Mar 29, 2016 at 11:08:55PM +0200, Arnd Bergmann wrote:
>>> On Tuesday 29 March 2016 14:00:18 Mark Brown wrote:

<snip>

>>> not impact the binding for the SPI host controller in any way, the
>>> binding just describes how the internal addressing is wired up to
>>> the mbus in hardware, and the mbus driver takes care of mapping those
>>> into CPU addresses.
>>
>> If we're able to do it automatically without baking this into the DT and
>> there's enough space to cope with this and PCI together then that's more
>> reasonable.
> 
> Ok, good. Then let's just do the SPI host driver like all the other
> mbus slaves using whatever mbus provides, and implement dynamic remapping
> of mbus windows whenever someone gets too annoyed with having to
> come up with a mapping for their board.
> 
> At least by doing SPI like all the other devices, we don't make it
> harder to come up with a generic algorithm for assigning the windows
> at boot time.

Okay, I'll implement the static mapping as suggested by Arnd in the
'reg' property of the SPI controller (additionally to the SPI controller
register range). Which will get configured and enabled in the 'ranges'
property of the per-board 'soc' node.

This will make the SPI driver patch very simple but will generate quite
a big Armada dts change, moving all the SPI controllers from the
'internal-regs' node to the 'soc' node though.

Please let me know if this is not the consensus.

Thanks,
Stefan

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
