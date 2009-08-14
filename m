From: Ben Dooks <ben@simtec.co.uk>
Subject: Re: [patch 0/7] SPI fixes for documentation and spi_s3c24xx driver
Date: Fri, 14 Aug 2009 15:06:36 +0100
Message-ID: <4A856F6C.5080802@simtec.co.uk>
References: <20090813100602.545180197@fluff.org> <20090813142455.2489ce67.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general@lists.sourceforge.net,
	dbrownell@users.sourceforge.net, linux-kernel@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756834AbZHNOGp@vger.kernel.org>
In-Reply-To: <20090813142455.2489ce67.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Andrew Morton wrote:
> On Thu, 13 Aug 2009 11:06:02 +0100
> Ben Dooks <ben@simtec.co.uk> wrote:
> 
>> Fix spello in the SPI documentation and fix the behaviour and bugs
>> in the spi_s3c24xx driver. 
>>
> 
> Do you think that any of these are needed in 2.6.31, or earlier?

The following would be useful to get in:
	spi_s3c24xx-fix-clock-rate-calculation.patch
	spi_s3c24xx-fix-transfer-setup-code.patch

The rest can wait.

-- 
Ben Dooks, Software Engineer, Simtec Electronics

http://www.simtec.co.uk/
