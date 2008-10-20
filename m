From: Mark Jackson <mpfj@mimc.co.uk>
Subject: Re: [PATCH v2] Add Dallas DS1390 RTC chip
Date: Mon, 20 Oct 2008 12:44:24 +0100
Message-ID: <48FC6F18.6040809@mimc.co.uk>
References: <48FC442E.9070206@mimc.co.uk> <20081020114607.1b0299cb@i1501.lan.towertech.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: dbrownell@users.sourceforge.net,
	lkml <linux-kernel@vger.kernel.org>, rtc-linux@googlegroups.com,
	spi-devel-general@lists.sourceforge.net
To: Alessandro Zummo <alessandro.zummo@towertech.it>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751916AbYJTLyD@vger.kernel.org>
In-Reply-To: <20081020114607.1b0299cb@i1501.lan.towertech.it>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Alessandro Zummo wrote:
> On Mon, 20 Oct 2008 09:41:18 +0100
> Mark Jackson <mpfj@mimc.co.uk> wrote:
> 
>> +struct ds1390 {
>> +	struct rtc_device *rtc;
>> +	u8 buf[9];	/* cmd + 8 registers */
>> +	u8 tx_buf[2];
>> +	u8 rx_buf[2];
>> +};
>> +
> 
>  don't we still have too many buffers?

Ah yes ... ooops !!

> 
>  the use of bin2bcd an bcd2bin (lowercase) would also be appreciated.
> 

Will do.

Mark
