From: =?ISO-8859-1?Q?Richard_R=F6jfors?=
	<richard.rojfors.ext@mocean-labs.com>
Subject: Re: [spi-devel-general] [RESEND][PATCH] SPI: xilinx_spi: Added platform
 driver and support for DS570
Date: Wed, 08 Jul 2009 11:15:32 +0200
Message-ID: <4A5463B4.2010403@mocean-labs.com>
References: <4A366622.2050606@mocean-labs.com> <200906231237.54278.david-b@pacbell.net> <4A41DF44.4060705@mocean-labs.com> <200907021809.01990.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: spi-devel-general@lists.sourceforge.net,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: David Brownell <david-b@pacbell.net>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759583AbZGHJPr@vger.kernel.org>
In-Reply-To: <200907021809.01990.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 7/3/09 3:09 AM, David Brownell wrote:
> On Wednesday 24 June 2009, Richard R=F6jfors wrote:
>> On 09-06-23 21.37, David Brownell wrote:
>>> On Monday 15 June 2009, Richard R=F6jfors wrote:
>>>> This patch splits xilinx_spi into three parts, an OF and a platfor=
m
>>>> driver and generic part.
>>>>
>>>> The generic part now also works on X86 and also supports the Xilin=
x
>>>> SPI IP DS570
>>> Your Kconfig still mentions only DS464.
>> Correct, will update.
>
> Just checking -- you didn't send an update yet, right?

Nope not yet. I will send it within the next weeks, I'm actually on=20
vacation.

--Richard
