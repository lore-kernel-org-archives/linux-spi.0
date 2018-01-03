From: "Wang, Haiyue" <haiyue.wang@linux.intel.com>
Subject: Re: [PATCH v1] eSPI: add Aspeed AST2500 eSPI driver to boot a host
 with PCH runs on eSPI
Date: Wed, 3 Jan 2018 22:28:22 +0800
Message-ID: <004d3017-5477-ec42-c78a-aba0ca0621bc@linux.intel.com>
References: <1514512387-27113-1-git-send-email-haiyue.wang@linux.intel.com>
 <CAK8P3a2nZzc22FgupGjGeS7uQkrxH_W7=T7m_foejDMHtp70_w@mail.gmail.com>
 <20180103113805.GD5603@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Joel Stanley <joel@jms.id.au>, gregkh <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
To: Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180103113805.GD5603@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org



On 2018-01-03 19:38, Mark Brown wrote:
> On Sun, Dec 31, 2017 at 12:10:51AM +0100, Arnd Bergmann wrote:
>> On Fri, Dec 29, 2017 at 2:53 AM, Haiyue Wang
>> <haiyue.wang@linux.intel.com> wrote:
>>> When PCH works under eSPI mode, the PMC (Power Management Controller) in
>>> PCH is waiting for SUS_ACK from BMC after it alerts SUS_WARN. It is in
>>> dead loop if no SUS_ACK assert. This is the basic requirement for the BMC
>>> works as eSPI slave.
>>>
>>> Also for the host power on / off actions, from BMC side, the following VW
>>> (Virtual Wire) messages are done in firmware:
>>> 1. SLAVE_BOOT_LOAD_DONE / SLAVE_BOOT_LOAD_STATUS
>>> 2. SUS_ACK
>>> 3. OOB_RESET_ACK
>>> 4. HOST_RESET_ACK
>> I have not looked at the driver contents yet, but I'm adding the SPI
>> maintainer and
>> mailing list to Cc here for further discussion. Can you clarify how
> More generally:
>
> As documented in SubmittingPatches please send patches to the
> maintainers for the code you would like to change.  The normal kernel
> workflow is that people apply patches from their inboxes, if they aren't
> copied they are likely to not see the patch at all and it is much more
> difficult to apply patches.
Should send to like this ? Because I add patch for Aspeed chip:

./scripts/get_maintainer.pl drivers/misc/aspeed-lpc-snoop.c
Joel Stanley <joel@jms.id.au> (maintainer:ARM/ASPEED MACHINE SUPPORT)
Arnd Bergmann <arnd@arndb.de> (supporter:CHAR and MISC DRIVERS)
Greg Kroah-Hartman <gregkh@linuxfoundation.org> (supporter:CHAR and MISC 
DRIVERS)
linux-kernel@vger.kernel.org (open list)
