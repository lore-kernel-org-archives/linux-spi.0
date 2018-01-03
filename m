From: "Wang, Haiyue" <haiyue.wang@linux.intel.com>
Subject: Re: [PATCH v1] eSPI: add Aspeed AST2500 eSPI driver to boot a host
 with PCH runs on eSPI
Date: Wed, 3 Jan 2018 22:34:07 +0800
Message-ID: <e03ec577-f818-ab2c-e554-6a31053a782c@linux.intel.com>
References: <1514512387-27113-1-git-send-email-haiyue.wang@linux.intel.com>
 <CAK8P3a2nZzc22FgupGjGeS7uQkrxH_W7=T7m_foejDMHtp70_w@mail.gmail.com>
 <20180103113805.GD5603@sirena.org.uk>
 <004d3017-5477-ec42-c78a-aba0ca0621bc@linux.intel.com>
 <20180103143226.GI5603@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Arnd Bergmann <arnd@arndb.de>, Joel Stanley <joel@jms.id.au>,
        gregkh <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180103143226.GI5603@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org



On 2018-01-03 22:32, Mark Brown wrote:
> On Wed, Jan 03, 2018 at 10:28:22PM +0800, Wang, Haiyue wrote:
>
>> Should send to like this ? Because I add patch for Aspeed chip:
>> ./scripts/get_maintainer.pl drivers/misc/aspeed-lpc-snoop.c
>> Joel Stanley <joel@jms.id.au> (maintainer:ARM/ASPEED MACHINE SUPPORT)
>> Arnd Bergmann <arnd@arndb.de> (supporter:CHAR and MISC DRIVERS)
>> Greg Kroah-Hartman <gregkh@linuxfoundation.org> (supporter:CHAR and MISC
>> DRIVERS)
>> linux-kernel@vger.kernel.org (open list)
> So it's not actually doing anything at all with the SPI subsystem?  I
> lacked any context for the discussion having been copied in part way
> through.  If it is a SPI controller it ought to have been in
> drivers/spi.
Yes, eSPI just uses the SPI pin definition, but it replaces LPC interface.
