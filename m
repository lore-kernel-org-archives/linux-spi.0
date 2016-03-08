From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] spi/spi-xilinx:  Add clock support
Date: Tue, 8 Mar 2016 10:02:23 -0800
Message-ID: <20160308180223.GU3173@xsjsorenbubuntu>
References: <1457426528-15247-1-git-send-email-shubhraj@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	<broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Shubhrajyoti Datta <shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
To: Shubhrajyoti Datta <shubhrajyoti.datta-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1457426528-15247-1-git-send-email-shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tue, 2016-03-08 at 14:12:08 +0530, Shubhrajyoti Datta wrote:
> Add basic clock support. The clocks are requested at probe
> and released at remove.
>=20
> Signed-off-by: Shubhrajyoti Datta <shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Acked-by: S=C3=B6ren Brinkmann <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>

Though, the DT bindings need to be updated accordingly.

	S=C3=B6ren
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
