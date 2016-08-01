From: sparticvs svcitraps <sparticvs-QL8avWE+bvHQT0dZR+AlfA@public.gmane.org>
Subject: Question about spi_transfer_one_message
Date: Mon, 1 Aug 2016 10:30:22 -0400
Message-ID: <6CA20599-DE9C-456B-A18D-D19AC8D07A04@popebp.com>
Mime-Version: 1.0 (Mac OS X Mail 10.0 \(3204\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hello.

I am writing a spi device driver, and I ran into some interesting behavior (at least interesting in terms of this spi device) regarding chip select.

For the spi_transfer_one_message, the logic for chip select bouncing is as follows (in pseudo code to ensure I understand it correctly and I am skipping abort paths):


BEGIN spi_transfer_one_message
cs_acquire()

FOR EACH xfr IN msg:
	ret := transfer_one(xfr)
	IF ret > 0:
		# wait for completion timeout (estimated)
		ms := estimate_xfr_time
	ENDIF

	IF xfr.delay:
		delay
	ENDIF

 	IF is_last(xfr):
		KEEP_CS := TRUE
	ELSE:
		cs_release
		delay
		cs_acquire
	ENDIF

	IF ret != OK OR NOT KEEP_CS:
		cs_release
	ENDIF

	finalize_curr_msg()
END


>From my understanding (and experiments) CS is held low even when there are no more transfers. What is the reason for this to be done this way?

The issue I am running into is that this spi-device (EPSON S1D13781 LCDC) requires that CS is bounced before the next command. I am not sure if this is required of all SPI devices, but it makes sense to me.

So, the only way that I could fix this issue, and get the proper behavior on chip was to change the code to:


BEGIN spi_transfer_one_message
cs_acquire()

FOR EACH xfr IN msg:
	ret := transfer_one(xfr)
	IF ret > 0:
		# wait for completion timeout (estimated)
		ms := estimate_xfr_time
	ENDIF

	IF xfr.delay:
		delay
	ENDIF

- 	IF is_last(xfr):
-		KEEP_CS := TRUE
-	ELSE:
+	IF NOT is_last(xfr):
		cs_release
		delay
		cs_acquire
	ENDIF

-	IF ret != OK OR NOT KEEP_CS:
-		cs_release
-	ENDIF
+	cs_release

	finalize_curr_msg()

END


Basically, this always forces the CS hold to be released when completing a message. Does this make sense for all other use-cases? If so, I can start a patch, but I just wasn’t sure if the current behavior was expected for all other operations. The only place where I can see this being in conflict is the use of `spi_transfer::cs_change’, but that said, this logic could (and probably should) use the cs_change to determine if it should keep the CS held low instead of the original logic.--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
