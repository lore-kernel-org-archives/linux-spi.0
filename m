From: Bernhard Walle <walle@corscience.de>
Subject: Re: [PATCH] spi: spidev: Add 32 bit compat ioctl()
Date: Thu, 03 Feb 2011 09:38:06 +0100
Message-ID: <4D4A696E.4050302@corscience.de>
References: <1296646296-31843-1-git-send-email-walle@corscience.de> <AANLkTikbXYxyUmBsPNO6mxB2x_4Qr49BQZTKrqvsiK8a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: dbrownell@users.sourceforge.net,
	spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	arnd@arndb.de
To: Grant Likely <grant.likely@secretlab.ca>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AANLkTikbXYxyUmBsPNO6mxB2x_4Qr49BQZTKrqvsiK8a@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Am 02.02.2011 15:15, schrieb Grant Likely:
>>  static int spidev_open(struct inode *inode, struct file *filp)
>>  {
>>        struct spidev_data      *spidev;
>> @@ -543,6 +552,9 @@ static const struct file_operations spidev_fops = {
>>        .write =        spidev_write,
>>        .read =         spidev_read,
>>        .unlocked_ioctl = spidev_ioctl,
>> +#ifdef CONFIG_COMPAT
>> +       .compat_ioctl = spidev_compat_ioctl,
>> +#endif
> 
> Then the #ifdef/#endif can be dropped here which is tidier.

Ok, thanks, I resent the patch with that modification.


Regards,
Bernhard
