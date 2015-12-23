From: Jisheng Zhang <jszhang@marvell.com>
Subject: Re: [RFC] spi: dw: support setting tmode dynamically
Date: Wed, 23 Dec 2015 20:29:52 +0800
Message-ID: <20151223202952.28be5bab@xhacker>
References: <20151223192338.128e95a4@xhacker>
	<20151223121512.GV16023@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Cc: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151223121512.GV16023@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Dear Mark,

On Wed, 23 Dec 2015 12:15:12 +0000 Mark Brown wrote:

> On Wed, Dec 23, 2015 at 07:23:38PM +0800, Jisheng Zhang wrote:
> 
> > Currently the spi-dw tmode is fixed to SPI_TMOD_TR if cs_control is NULL, but we
> > need to set it as SPI_TMOD_EPROMREAD to read nor flash, my solution is to add and
> > export one functions to set the tmode, then the nor flash driver call it
> > before reading and set back to SPI_TMOD_TR after done.  
> 
> What does this mean - what is TMOD and why do we need to set it to read
> NOR flash?  I've no information on this controller...

TMOD is one field of DW_SPI_CTRL0. Its available value could be:

0: Transmit and Receive

1: Transmit only

2: Receive only

3: EEPROM Read

If the one spi nor flash is connected to the SPI host, so far I can only succeed
to read the nor flash content after setting the TMOD field as 3.

Thanks,
Jisheng
