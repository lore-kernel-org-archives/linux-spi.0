From: Christer Weinigel <christer@weinigel.se>
Subject: Re: [PATCH] devicetree - document using aliases to set spi bus
 number.
Date: Tue, 24 May 2016 20:03:48 +0200
Message-ID: <57449784.4070108@weinigel.se>
References: <1464107960-10775-1-git-send-email-christer@weinigel.se>
 <20160524172045.GN8206@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160524172045.GN8206@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


On 05/24/2016 07:20 PM, Mark Brown wrote:
>> Not having used devicetree that much it was surprisingly hard to 
>> figure out how to assign a stable bus number to a spi bus.  Add
>> a simple example that shows how to do that.
> 
> I'm not sure this is something we want to support at all, I can't 
> immediately see anything that does this deliberately in the SPI
> code and obviously the "bus number" is something of a Linux
> specific concept which would need some explanation if we were going
> to document it.  It's something I'm struggling a bit to see a
> robust use case for that isn't better served by parsing sysfs,
> what's the goal here?

Well, that's how it works right now:

commit bb29785e0d6d150181704be2efcc3141044625e2
Author: Grant Likely <grant.likely@secretlab.ca>
Date:   Fri Dec 21 19:32:09 2012 +0000

    spi/of: Use DT aliases for assigning bus number

> + if ((master->bus_num < 0) && master->dev.of_node) +
> master->bus_num = of_alias_get_id(master->dev.of_node, "spi");

If this isn't something that should be in the Documentation/devicetree
 because it's not generig enough, where should Linux-specific
interpretations such as this be documented?

  /Christer
