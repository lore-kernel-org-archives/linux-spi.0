From: Ryan Mallon <ryan@bluewatersys.com>
Subject: Re: [spi-devel-general] [PATCH] SST25L (non JEDEC) SPI Flash driver
Date: Mon, 22 Jun 2009 16:25:36 +1200
Message-ID: <4A3F07C0.9030001@bluewatersys.com>
References: <4A3F017B.2010409@bluewatersys.com> <20090622041457.GC6027@tarshish>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: David Woodhouse <dwmw2@infradead.org>,
	linux-mtd@lists.infradead.org,
	spi-devel-general@lists.sourceforge.net, mike@steroidmicros.com,
	linux kernel <linux-kernel@vger.kernel.org>
To: Baruch Siach <baruch@tkos.co.il>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753168AbZFVEXl@vger.kernel.org>
In-Reply-To: <20090622041457.GC6027@tarshish>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Baruch Siach wrote:
> Hi Ryan,
> 
> On Mon, Jun 22, 2009 at 03:58:51PM +1200, Ryan Mallon wrote:
>> +static int sst25l_erase_block(struct sst25l_flash *flash, u32 offset)
>> +{
>> +	u8 command[4];
>> +	int err;
>> +
>> +	err = sst25l_write_enable(flash, 1);
> 
> Is this enable/disable strictly required for each write/erase? Can't we just 
> enable write once?

The datasheet says that prior to any write/erase instruction the write
enable instruction must be sent.

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

       Ryan Mallon                              Unit 5, Amuri Park
       Phone: +64 3 3779127                     404 Barbadoes St
       Fax:   +64 3 3779135                     PO Box 13 889
       Email: ryan@bluewatersys.com             Christchurch, 8013
       Web:   http://www.bluewatersys.com       New Zealand
       Freecall Australia  1800 148 751         USA 1800 261 2934
