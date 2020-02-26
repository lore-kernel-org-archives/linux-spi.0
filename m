From: "Herbrechtsmeier Dr.-Ing. , Stefan"
        <stefan.herbrechtsmeier-oss-2t/0UIm1CeVDOHtkgc7UlQ@public.gmane.org>
Subject: Re: Execute spi transfers inside FIQ (NMI) or panic
Date: Wed, 26 Feb 2020 08:36:37 +0100
Message-ID: <d07a46e6-6c8f-c4eb-0ed1-d57b7604a5be@weidmueller.com>
References: <b22800b8-9c03-63a5-7ade-d8b63c562580@weidmueller.com>
 <20200225155354.GF4633@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200225155354.GF4633-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Am 25.02.2020 um 16:53 schrieb Mark Brown:
> On Tue, Feb 25, 2020 at 02:27:27PM +0100, Herbrechtsmeier Dr.-Ing. , Stefan wrote:
>
>> would it be acceptable to add an additional function to the struct
>> spi_controller which handle a transfer inside a NMI context or a panic? The
>> new function will transfer data via register polling without any lock.
> That would need to happen as part of a wider change that made it
> possible to use such an interface safely and did so, off the top of my
> head it's not immediately obvious how one would do that.  You'd need to
> get the hardware into a sensible state and then do whatever needs doing
> with some cooperation from the client driver in all this which is a bit
> of an ask.  It's not a trivial bit of work, but I do see the use case
> and it's absolutely valid.

I see two possible solutions.
a) The complexity is handled inside the client. The client uses the 
controller exclusive and isn’t allowed to use the new panic transfer 
during a normal transfer.
b) The complexity is handled inside the controller. The controller is 
shared between multiple slaves and a panic transfer must abort a running 
transfer.

The first solution keeps the controller driver simple because only a new 
polled transfer is needed. But the prepare and unprepare functions must 
be lock free and power management must be handled lock free to be reused.

The second solution could lead to code duplication because an addition 
panic prepare function must setup the controller from any state and must 
abort a running transfer. Especially the abort could be complex and 
difficult to test. Otherwise the new functionality could be used without 
any constraints.
