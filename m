From: Frode Isaksen <fisaksen-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: spi: spidev_test: add option to continuously transfer data - v2
Date: Tue, 21 Mar 2017 16:48:45 +0100
Message-ID: <1490111326-21215-1-git-send-email-fisaksen@baylibre.com>
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
To: nsekhar-l0cyMroinI0@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

v2 changes:
- fix bug, hex_dump() dumped tx instead of rx buffer.
- indentation fixes in for() loop and limit long lines.
- exit(1) instead of exit(-1) in case of error.
- simplify function show_transfer_rate().

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
