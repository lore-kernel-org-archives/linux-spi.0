From: Vernon Sauder <vernoninhand-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: pxa2xx_spi with SFRM
Date: Mon, 11 Aug 2008 18:55:25 -0400
Message-ID: <48A0C35D.5010606@gmail.com>
References: <1218182539.489bfd8b24a3d@webmail.whoi.edu>
	<489C1B23.6040804@cam.ac.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080702060008090603080702"
Cc: nforrester-/d+BM93fTQY@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <489C1B23.6040804-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

This is a multi-part message in MIME format.
--------------080702060008090603080702
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

First, thanks for your replies. I am sorry. I left town for the weekend 
and I forgot to include all the details.

Jonathan Cameron wrote:
> nforrester-/d+BM93fTQY@public.gmane.org wrote:
>   
>> I am as sea right now, with very limited email access.  If you can
>> wait until Wed or Thursday of next week, I might be of more help.  In
>> the mean time perhaps someone else will reply.
>>
>> Since the orignal author, Stephen Steet, became silent on this driver,
>> I and several others have submitted patches for it.  I use an
>> extensivley modified version of pxa2xx_spi.c for one of my projects
>> and thus I have some familiarity with the driver, though somewhat less
>> with the details of SPI (I use the TI synchonous mode) and none at all
>> with flash on SPI.  I also work on a PXA255, and the PXA270 has some
>> differences.
>>     
> I can offer a few additional comments on this (as a PXA271 spi user)
>   
Good. We have a nice set of different HW. Sorry to hear that Steve 
became quiet.
>   
>>> I am using a custom PXA270 board and tried to use the SSP port to
>>> communication with a SPI Flash. After reading docs on how to configure
>>> the spi_master and spi devices, I have the device driver's probe being
>>> called. But I cannot get the pxa2xx_spi driver to work correctly. I
>>> can connect either a SD card or a M26P16 Flash chip to the SPI port on
>>> my board. Neither device driver can completely operate their device.
>>>
>>> It looks like it is impossible for the device drivers to control the
>>> chip select (CS) line. If I use the manual cs_control callback, the
>>> timing is invalid because the SSP clock keeps running.
>>>       
>> The cs_control() callback is the normal way of controlling chip select
>> with this driver.  That allows you to assign any GPIO pin or polarity.
>> I understand that this differs from way that the spi core expects chip
>> select to be handeled; in particular, the driver does not honor the
>> SPI_CS_HIGH nor SPI_LSB_FIRST bits in the spi_device.mode.  The PXA
>> SSP controllers do not have a dedicated chipselect mechanism
>> associated with the SSP controllers (outside of the single FRAME pin,
>> which may or may not do what you want), thus the use of GPIO lines is
>> required.
>>
>> What version of the kernel/driver are you using?  There have been some
>> recent changes, and there may still be a bug regarding CS changes that
>> was discussed in:
>> Re: [spi-devel-general] odd behaviour of chipselect with bitbang driver?
>> on about 04/24/08 15:55.  I raised the question but, since I don't use
>> chipselect at all, I have not produced a patch.
>>
>>     
I am using 2.6.24.4 on custom HW. I am using the FRAME pin as the chip 
select so I was hoping I did not have to use cs_control().

I'll look up that patch, thanks.
>> The fact that the clock free runs strikes me as strange, I don't think
>> any of the supported SPI_MODE_n combinations can produce a free
>> running clock, though they do control polarity and phase of the clock.
>> If your problem involves one extra clock edge, you may have the wrong
>> setting for SPI_MODE_n.`
>>     
> Although the clock can free run in some of the other (non spi modes)
> the driver doesn't support this which means the behaviour is somewhat
> odd!  Any chance you can make available a picture of an oscilloscope trace
> showing SFRM and the clock?  That'll probably give sufficient clues to
> allow us to figure out what is going wrong.  I've used gpio based chip
> selects on the pxa271 wihout problems (though it does tend to slow down
> your transfers somewhat so is best avoided where possible).
>   
I attached a Logic Analyzer screen shot of m25p80 driver starting to 
query the device. The RX line is floating when the m25pxx chip is not 
driving it. But notice that the clocks are running before the FRM/CS 
line is active. If I use cs_control(), then there would be several clock 
edges (when using high speeds) before the PXA SSP controller would start 
clocking data.
>>> That means that
>>> several bits are clocked out before the SSP controller starts to drive
>>> the TX line correctly. If the SFRM signal is used, it does not allow
>>> the driver to keep CS active for multiple transactions as they expect
>>> and assume. The spi_sync call takes an spi_message which contains a
>>> list of transactions to send. Normally, the device will need the CS
>>> active during the complete message. But the SSP controller deactivates
>>> SFRM when it is done with each buffer. For instance, the M25P16
>>> datasheet indicates that CS has to stay active from the READ command
>>> through the complete data transfer. When it goes high, it resets the
>>> command interface.
>>>       
>> The driver should honor the per-transfer spi_transfer.cs_change flag
>> when used with a cs_control routine.  If you want the CS to stay
>> asserted between transfers, be sure the cs_change flag is 0.
>>     
>
> Indeed it should but it doesn't.  Unfortunately the hardware doesn't
> seem to have the ability to do this, so it will only work if using
> a gpio as the chip select.  Guess we really ought to add some stuff to
> the docs to make this clear (it wasted a good few hours of my time
> failing to understand why it didn't do anything!)  For short
> transfers (sub 16 x 32bits) you can get away with doing the endianess
> changes necessary and sending as a single multiword transfer.
> Afraid I'm usually dealing with sensors, adc's etc and they don't
> tend to need larger transfers than this between deasserting the chip
> select.
>  
>   
>>> It looks like the SSP port needs to have a register bit to turn off
>>> the clock when there is nothing to transmit. Or a bit to tell the SSP
>>> controller to leave CS active. Or I can change the HW so CS gates the
>>> clock and a manual CS chip operates the device CS pin. I might also
>>> try the bitbanging SPI driver next to see if that can operate with the
>>> Flash chip.
>>>       
>> pxa2xx_spi.c uses format SSCR0_Motorola.  I think, as I said above,
>> that this mode does not allow the clock to free run.  I expect that
>> you have some other problem.  As I understand it (and I may be wrong,
>> since I don't use Motorola SPI format) the clock is only active if
>> data is being transfered, and data is only transferred if there is
>> something the in the transmit FIFO to go out (and thus something to
>> receive at the same time).
>>     
>
> That should certainly be the case.  I guess it's just possible that SSCR1 
> is preset by something else to continuous clock mode? Don't think the driver
> explicitly clears it and a quick glance suggests elements of that register
> are set from chip specific data.
>   
Here are the registers:

root@inhand-ft4 [~] # md 0x41000000 0x3f
00000000  87 19 00 00 00 00 00 00  24 f0 00 00 00 00 00 00  |........$.......|
00000010  70 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |p...............|
00000020  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
*
00000030


>>  I wonder if you have a zero byte in the TX
>> FIFO when you think you have nothing.  Perhaps spi_transfer.len is not
>> set right.
>>
>>     
>>> Is there some other setting I am missing here? Is anyone else using
>>> the M25P16 chip with PXA270 SPI driver?
>>>       
> Not that chip, but I've got a good scope wired up to spi on
> a pxa271 so should be able to debug this without the chip.
>   
I may be able to send you a chip if you like.

I did some further research on this and found that the spidev driver 
works to at least query the flash chip. From userspace, I simply use a 
single transfer (via IOCTL) for each command. But that does not give me 
the m25p80 driver on top of the SPI; I would be re-inventing the wheel.

I also modified spi.c file to make spi_write_then_read() use one 
transfer so the m25p80 driver's JEDEC probe works. It is an example of 
the difference that would have to be done to get the pxa27x to work right.

--- ./src.old/drivers/spi/spi.c	2008-03-24 14:49:18.000000000 -0400
+++ ./src.cache/drivers/spi/spi.c	2008-08-11 17:49:50.000000000 -0400
@@ -564,7 +566,6 @@
 #define	SPI_BUFSIZ	max(32,SMP_CACHE_BYTES)
 
 static u8	*buf;
-
 /**
  * spi_write_then_read - SPI synchronous write followed by read
  * @spi: device with which data will be exchanged
@@ -592,7 +593,7 @@
 
 	int			status;
 	struct spi_message	message;
-	struct spi_transfer	x[2];
+	struct spi_transfer	x;
 	u8			*local_buf;
 
 	/* Use preallocated DMA-safe buffer.  We can't avoid copying here,
@@ -603,15 +604,9 @@
 		return -EINVAL;
 
 	spi_message_init(&message);
-	memset(x, 0, sizeof x);
-	if (n_tx) {
-		x[0].len = n_tx;
-		spi_message_add_tail(&x[0], &message);
-	}
-	if (n_rx) {
-		x[1].len = n_rx;
-		spi_message_add_tail(&x[1], &message);
-	}
+	memset(&x, 0, sizeof x);
+	x.len = n_tx + n_rx;
+	spi_message_add_tail(&x, &message);
 
 	/* ... unless someone else is using the pre-allocated buffer */
 	if (!mutex_trylock(&lock)) {
@@ -622,15 +617,15 @@
 		local_buf = buf;
 
 	memcpy(local_buf, txbuf, n_tx);
-	x[0].tx_buf = local_buf;
-	x[1].rx_buf = local_buf + n_tx;
+	x.tx_buf = local_buf;
+	x.rx_buf = local_buf;
 
 	/* do the i/o */
 	status = spi_sync(spi, &message);
 	if (status == 0)
-		memcpy(rxbuf, x[1].rx_buf, n_rx);
+		memcpy(rxbuf, x.rx_buf + n_tx, n_rx);
 
-	if (x[0].tx_buf == buf)
+	if (x.tx_buf == buf)
 		mutex_unlock(&lock);
 	else
 		kfree(local_buf);



Let me know if there is anything else I can do to clarify this. I want 
to know what the SPI is capable of and what the limitations are.

Vernon Sauder


--------------080702060008090603080702
Content-Type: image/jpeg;
 name="Pxa270Spi.jpg"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="Pxa270Spi.jpg"

/9j/4AAQSkZJRgABAQEAYABgAAD/2wBDAAgGBgcGBQgHBwcJCQgKDBQNDAsLDBkSEw8UHRof
Hh0aHBwgJC4nICIsIxwcKDcpLDAxNDQ0Hyc5PTgyPC4zNDL/2wBDAQkJCQwLDBgNDRgyIRwh
MjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjL/wAAR
CAEYBAoDASIAAhEBAxEB/8QAHwAAAQUBAQEBAQEAAAAAAAAAAAECAwQFBgcICQoL/8QAtRAA
AgEDAwIEAwUFBAQAAAF9AQIDAAQRBRIhMUEGE1FhByJxFDKBkaEII0KxwRVS0fAkM2JyggkK
FhcYGRolJicoKSo0NTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqDhIWG
h4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uHi4+Tl
5ufo6erx8vP09fb3+Pn6/8QAHwEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoL/8QAtREA
AgECBAQDBAcFBAQAAQJ3AAECAxEEBSExBhJBUQdhcRMiMoEIFEKRobHBCSMzUvAVYnLRChYk
NOEl8RcYGRomJygpKjU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6goOE
hYaHiImKkpOUlZaXmJmaoqOkpaanqKmqsrO0tba3uLm6wsPExcbHyMnK0tPU1dbX2Nna4uPk
5ebn6Onq8vP09fb3+Pn6/9oADAMBAAIRAxEAPwDsvCHhDwzc+CtBuLjw7pEs0unW7ySSWUbM
7GNSSSVyST3rZ/4Qnwp/0LGi/wDgBF/8TR4J/wCRC8O/9gy2/wDRS1u1g2UYX/CE+FP+hY0X
/wAAIv8A4mj/AIQnwp/0LGi/+AEX/wATUGsa5d2mvRadDd6ZZboo3hGoZH2+RmZTDEwYbWXa
uSFkP71fl4Aa3N4jsbO5uoZ7h5pY5/KEFrZyyypiONzlUDFgPMUlwAo8xVPPU1Aj/wCEJ8Kf
9Cxov/gBF/8AE0f8IT4U/wChY0X/AMAIv/iaLPxloF/NFFbX/mNJ5XPkyBU81FeLexXCbw6h
dxG4kqMsCBHqfiiC3BhtQ4u0vLeBo7q2liDo9xHC7RlgokAEn3lJAJXPBGTUCT/hCfCn/Qsa
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
5fwS6YdEa+hghthHsb7RsXcxZmZguQSCqn+6KPCGsa7d+O/GGj6xfwXcemfYvs4gthCieZEz
NgFmbnj7zN04wDigDuKK870vV9c8TP4l1S18Qx6Z4bivY4rK7e2iciGBT9pkjc/IUdh8sjFw
ArfKD0w9L8V+KtT1Pw1pUuoz29jrGoaibXUhbRLc3NlDGHgcq6FF3Fjn92pIVSAM5YA9gorw
fTPiJ4q17RY5Dqv2Ka28KXervJa28WbieKd4l3iRWAXEYJCheWPQYAk1D4keKHt7y/jvo7ae
Cy0i4tLWCBGtJGuAplFzIwYwjLELuki+UAjOdxAPdKK4/wCId74is9O0f/hHEvmmm1WGG7+w
wRyyC3IfeR5gKLyF+ZsAHGSBmpPCGv8A9p27xRNrN+8V7PaXkt8tqjWMsQGY38raGB4IKB/v
ckdgDrKK8n8E6/4gu/7GsfFmpeI9O1nVYrryEms7OOGRo852qIzIjKpVxvAUlf4gQDqeG9X1
248S+JJob/Utb0XSXXT4oGjtVluLsFTKVO2EKIwQuGyGySCeBQB6JRXnfxH1bX/DVrPq9hrc
iEvbpZWH2BRa581Fk+03DAhQwfg74gAOMnJrP07xJrtr4luF8TXniCxs5/Ecmn6ay2lqtrKm
cwo25DMQ2CN68YI+YHJAB6pRXn/j3X9R0vxf4S0221K+srHUftn2s2FmtzM3lxqybVMch6nn
C9Cc9Mjj7/4k+JfCuo+HZtfknXSLjVb+F3ubVYZriyUxrFNIgTcrLvZtqqhYKOOckA9worzf
4a+PLjxx4o8Xuk+/SLSW3TT02AYQiQF87Q3z7A2G+7nFekUAFFFFABRRRQAUUUUAFFFFABRR
RQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUA
FFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRR
RQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUA
FFFFABRRRQAUUUUAY/iLw3Z+JbO1gupJ4ZLS7ivbaeBgHhmjOVYBgVPUjDAjnpnBGPN8ONHu
PCGqeHJbm+aHVbtr29ut6CaWYyK5b7uxeUUYCgYHTPNFFAEniHwDZeIdZn1R9T1KznuNMbSp
ltTFtkt2YsynfGxBJPUEHgYxXQQaXaWujRaTbpJDZxW4to1jldWSMLtADg7gQP4s575zRRQB
h6Z4Hs7DUZdRudU1XUr59PGmrc3dwFkjtwSxUNEqHcSc7zl8gYI5zXi+Hdgft0l9quq6jdXe
lHRzdXcsZkjtjnIBVFDMSc7nDHIHPXJRQB0mk6bDo2jWOl27SNBZW8dvG0hBYqihQTgAZwPQ
Vz+v/DzRfEmvNrN+92LwWQs4XhkCG3KyeYs0bY3LKrdGzjGQQQTkooAJfAVtJql1qEetazbT
3yWy6gbadIjeGDhWZlQMhI4PlFAR2FR/8K40f/n5vv8AkYP+Eh++n/Hx/d+7/q/br/tUUUAb
GgeG7Pw5/an2OSd/7S1CXUJvOYHbJJjcFwBheBgHJ962KKKACiiigAooooAw9d8L22uX+mai
bu7stQ0x5Gtbq1KFkEibHUrIrIQRjquRgYI5zn6F8PNF8PXulXNm9240uyeztYZ5BIkZdy8k
wBGRKxJBYEDBxgDAoooA1P8AhG7P/hMv+Eo8yf7d/Z/9n+XuHl+X5nmZxjO7PfOMdqrr4Rs4
9T8R6jDeX0N1r8UcVxJFKFMPlxmNWiIXKtg5yc8gUUUAU734faVeeDtN8LpcXdrp9g8TqIPL
/flMn96rIUcFjvYFcFhk1Jd+C1vp9OvLnXtVfU9NllktL/FuJI1kTY6bRF5ZUgZ5QsD0Paii
gDLHwm0GCwt7Swu9SsBHpkulSyQyIzXFvI5d1fzEYAlizZUKRuIHAAEl58KvD919phjlvraw
u4rSG8sYZVMdyltgRBmZWkXAAU7GXIHrk0UUAdRrGlf2vZpAL++sJI5UmjnspvLdWU5wQQVd
TyCrBlOemcEZ+heE4PD2fsWo3x867nvb3zPKP2yaXq0nyDbjAwI9g45BoooAr2XgeztdcsdV
n1TVdQk07z/sMd7cCQW3nffw20SPx8o8xmwPfBqxonhODw54Qg8OaTqN9bwwbvLuv3TzLukL
n7yFDySOV6e/NFFAFfxB4Hs/Ektyt9qmq/YLvyftWnJcAwS+U24YDKWjzgZ8tkzjPXmi68D2
d9rEF7eapqtxbwagupQ2E1wHhjuFXCspK+YFBJYIH2A9scUUUAaGo+G7PU/Eei65NJOt1pHn
/Z0RgEbzUCNuBGTgDjBH41X8QeDtL8Tanp17qXnv9hiuYVhR9qSpcR+XIG43fd6bSMUUUAHh
/wAHaX4Z1PUb3TfPT7dFbQtC77kiS3j8uMLxu+713E5roKKKACiiigAooooAKKKKACiiigAo
oooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKK
ACiiigAooooAKKKKACiiigAooooAKKKKAP/Z
--------------080702060008090603080702
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--------------080702060008090603080702
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
spi-devel-general mailing list
spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/spi-devel-general

--------------080702060008090603080702--
