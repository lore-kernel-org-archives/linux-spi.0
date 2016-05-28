From: Christer Weinigel <christer@weinigel.se>
Subject: Re: [PATCH] devicetree - document using aliases to set spi bus
 number.
Date: Sat, 28 May 2016 22:57:33 +0200
Message-ID: <574A063D.5030700@weinigel.se>
References: <1464107960-10775-1-git-send-email-christer@weinigel.se>
 <20160524174140.GE11605@leverpostej> <5744BC76.9090403@gmail.com>
 <20160525092034.GE1337@leverpostej> <5745C5A3.6060202@gmail.com>
 <20160525174809.GA8206@sirena.org.uk> <5745F30B.2040605@gmail.com>
 <20160527183629.GO16172@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org
To: Mark Brown <broonie@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160527183629.GO16172@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 05/27/2016 08:36 PM, Mark Brown wrote:
> Personally the way I parse this situation is that the kernel is taking 
> a look at what's in the DT and making an effort to present it usefully 
> in the running systems. Fixing our current interpretation in stone as 
> a supported thing when we don't have to makes it more cumbersome to 
> improve and discourages any efforts to do similar things in the 
> future. It is reasonable to provide and document something here but 
> when there's some fairly simple and obvious better things we could be 
> doing it should be those rather than the legacy stuff. 

So what are the "simple and obvious better things" that one can use instead?

   /Christer

-- 
Have laptop, will travel.  I'm a consultant looking for interesting
jobs anywhere in the world.  I'm an experienced software engineer with
a solid understanding of hardware.  Specialities: Linux, device
drivers and embedded systems in general.  Find me at www.weinigel.se.
