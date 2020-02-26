From: "Herbrechtsmeier Dr.-Ing. , Stefan"
        <stefan.herbrechtsmeier-oss-2t/0UIm1CeVDOHtkgc7UlQ@public.gmane.org>
Subject: Re: Execute spi transfers inside FIQ (NMI) or panic
Date: Wed, 26 Feb 2020 16:28:17 +0100
Message-ID: <6a725569-db34-cf41-cb13-1b3d3a7aad23@weidmueller.com>
References: <b22800b8-9c03-63a5-7ade-d8b63c562580@weidmueller.com>
 <20200225155354.GF4633@sirena.org.uk>
 <d07a46e6-6c8f-c4eb-0ed1-d57b7604a5be@weidmueller.com>
 <20200226113333.GC4136@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200226113333.GC4136-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Am 26.02.2020 um 12:33 schrieb Mark Brown:
> On Wed, Feb 26, 2020 at 08:36:37AM +0100, Herbrechtsmeier Dr.-Ing. , Stefan wrote:
>
>> I see two possible solutions.
>> a) The complexity is handled inside the client. The client uses the
>> controller exclusive and isn’t allowed to use the new panic transfer during
>> a normal transfer.
> Then someone builds a system with two devices attached to a single SPI
> controller...  besides, you've got no mechanism for controlling when a
> kernel might panic or power might be lost.  I'm not sure a scheme that
> relies on being able to control when stuff happens is going to be what
> you need.

In my case this works because I read from the device during probe and 
write to the device during a panic or after power failure. But I 
understand that this isn't a generic solution.
