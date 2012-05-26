From: John Crispin <blogic-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Subject: Re: [PATCH V5 16/17] SPI: MIPS: lantiq: add FALCON spi driver
Date: Sat, 26 May 2012 15:47:24 +0200
Message-ID: <4FC0DEEC.8050204@openwrt.org>
References: <1337521579-1597-1-git-send-email-blogic@openwrt.org>
	<20120525233845.BD93C3E0BD2@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, Thomas Langer <thomas.langer-th3ZBGNqt+7QT0dZR+AlfA@public.gmane.org>,
	Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20120525233845.BD93C3E0BD2@localhost>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org


> What exactly does this mean?  How does it not support any other type
> of SPI peripheral?  SPI is a really simple protocol, so what is it
> about this hardware that prevents it being used with other SPI
> hardware?
>
> I see a big state machine that appears to interpret the messages and
> pretend to be an SPI slave instead of telling linux about the real
> device.  /me wonders if it should this instead be a block device
> driver?
>

Thomas will need to comment on this part

>> +static int falcon_sflash_prepare_xfer(struct spi_master *master)
>> +{
>> +	return 0;
>> +}
>> +
>> +static int falcon_sflash_unprepare_xfer(struct spi_master *master)
>> +{
>> +	return 0;
>> +}
> Don't use empty hooks.  Just leave them uninitialized.  The core will
> do the right thing.
>

I was under the impression that the need for these 2 callbacks was
removed in 3.5. As this patch flows via MIPS there would be a merge
order problem making the kernel non bisectable

I am a bit confused. You keep ack'ing this driver and then commenting on
it a few weeks later.... obsoleting the ACK ...








------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
